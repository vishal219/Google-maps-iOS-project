//
//  ViewController.swift
//  Maps
//
//  Created by vishalthakur on 09/12/21.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    //Outlets:
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var truckList: UITableView!
    @IBOutlet weak var list: UIView!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var changeView: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Variables used:
    var trucks : [Truck] = []
    var filteredTrucks : [Truck] = []
    var filterOn:Bool = false
    var markers: [String:GMSMarker] = [:]
    var mapView: GMSMapView? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
        registerNib()
        truckList.estimatedRowHeight = 75
        truckList.dataSource = self
        truckList.delegate = self
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 8
        searchBar.showsCancelButton = true
    }
    ///get API data
    func getData(){
        api.getData(completion: { trucklist in
            self.trucks = trucklist
            
            DispatchQueue.main.async {
                self.setupMap()
                self.truckList.reloadData()
            }
        })
    }
    ///get Centre of map
    func getCentre() -> (Float,Float){
        var lat: Float = 0.0
        var long: Float = 0.0
        for item in trucks{
            lat = lat + item.lastWaypoint.lat
            long = long + item.lastWaypoint.lng
        }
        lat = lat/Float(trucks.count)
        long = long/Float(trucks.count)
        return (lat,long)
    }
    ///Setup the map view
    func setupMap(){
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(getCentre().0), longitude: CLLocationDegrees(getCentre().1), zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: self.map.bounds, camera: camera)
        self.map.addSubview(mapView)
        self.mapView = mapView
        // Creates a marker in the center of the map.
        for item in trucks{
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(item.lastWaypoint.lat), longitude: CLLocationDegrees(item.lastWaypoint.lng))
        
        marker.map = mapView
            if item.lastRunningState.truckRunningState == 1{
                marker.icon = UIImage(named: greenTruck)
            }
            else{
                if item.lastWaypoint.ignitionOn{
                    marker.icon = UIImage(named: blueTruck)
                }
                else{
                    marker.icon = UIImage(named: yellowTruck)
                }
            }
            let time = Date(timeIntervalSince1970: TimeInterval(item.lastWaypoint.updateTime/1000))
             if Date().hours(from: time) > 4{
                 marker.icon = UIImage(named: redTruck)
            }
            markers[item.truckNumber] = marker
        }
    }
    
    ///changing to map/list via button click
    @IBAction func changeToMapOrList(_ sender: Any) {
        if list.isHidden{
            map.isHidden = true
            list.isHidden = false
            search.isHidden = false
            constraint.constant = 56
            changeView.setImage(UIImage(named: "mapImage"), for: .normal)
        }
        else{
            map.isHidden = false
            list.isHidden = true
            search.isHidden = true
            constraint.constant = 8
            changeView.setImage(UIImage(named: "listImage"), for: .normal)
        }
    }
    ///show search box
    @IBAction func searchClicked(_ sender: Any) {
        topView.isHidden = true
        searchBar.isHidden = false
        searchBar.becomeFirstResponder()
        filterOn = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        topView.isHidden = false
        //filterOn = false
       // truckList.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterTrucks(searchText)
    }
    ///filter trucks according to search query
    func filterTrucks(_ query : String){
        filteredTrucks.removeAll()
        for item in trucks{
            if item.truckNumber.lowercased().starts(with: query.lowercased()){
                filteredTrucks.append(item)
                markers[item.truckNumber]?.map = mapView
            }
            else{
                markers[item.truckNumber]?.map = nil
            }
        }
        truckList.reloadData()
        
    }
}

extension ViewController{
    func registerNib(){
        let nib = UINib.init(nibName: "Vehicle", bundle: nil)
        self.truckList.register(nib, forCellReuseIdentifier: "truck")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterOn{
            return filteredTrucks.count
        }
        return trucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = truckList.dequeueReusableCell(withIdentifier: "truck", for: indexPath) as! Vehicle
        if filterOn{
            cell.truck = filteredTrucks[indexPath.row]
        }
        else{
            cell.truck = trucks[indexPath.row]
        }
        let time = Date(timeIntervalSince1970: TimeInterval(cell.truck.lastWaypoint.updateTime/1000))
        if Date().hours(from: time) > 4{
            cell.contentView.backgroundColor = .red
        }
        return cell
    }
    
}
