//
//  ViewController.swift
//  Maps
//
//  Created by vishalthakur on 09/12/21.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    @IBOutlet weak var list: UIView!
    
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var changeView: UIButton!
    var trucks : [Truck] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMap()
        
        
    }
    
    func setupMap(){
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: self.map.bounds, camera: camera)
        self.map.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        marker.icon = UIImage(named: "truck-32")
        
    }
    
    //changing to map list via button click
    @IBAction func changeToMapOrList(_ sender: Any) {
        
    }
    
}

