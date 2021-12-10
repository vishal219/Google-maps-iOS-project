//
//  Vehicle.swift
//  Maps
//
//  Created by vishalthakur on 09/12/21.
//

import UIKit

class Vehicle: UITableViewCell {

    @IBOutlet weak var shadowLayer: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    @IBOutlet weak var runningState: UILabel!
    @IBOutlet weak var truckNo: UILabel!
    
    var truck: Truck! {
        didSet{
            truckNo.text = truck.truckNumber
            
            var state = "Running"
            if truck.lastRunningState.truckRunningState == 0{
                state = "Stopped"
            }
            
            let date = Date(timeIntervalSince1970: TimeInterval(truck.lastRunningState.stopStartTime/1000))
            if Date().days(from: date) > 0{
                runningState.text = state + " since last \(Date().days(from: date)) days"
            }
            else if Date().hours(from: date) > 0{
                runningState.text = state + " since last \(Date().hours(from: date)) hours"
            }
            else{
                runningState.text = state + " since last \(Date().minutes(from: date)) mins"
            }
          
            var str = ""
            let time = Date(timeIntervalSince1970: TimeInterval(truck.lastWaypoint.createTime/1000))
            if Date().days(from: time) > 0{
                str = "\(Date().days(from: time)) days"
            }
            else if Date().hours(from: time) > 0{
                str = "\(Date().hours(from: time)) hours"
            }
            else if Date().minutes(from: time) > 0{
                str = "\(Date().minutes(from: time)) mins"
            }
            else{
                str = "\(Date().seconds(from: time)) sec"
            }
            
            let string = NSMutableAttributedString(string: str,attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 207.0/255.0, green: 60.0/255.0, blue: 53.0/255.0, alpha: 1.0),NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)])
            string.append(NSAttributedString(string: " ago"))
            lastUpdated.attributedText = string
            //lastUpdated.text = "\(updated.0) \(updated.1) ago"
            if truck.lastRunningState.truckRunningState != 0{
                let attributedText = NSMutableAttributedString(string: "\(truck.lastWaypoint.speed)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 207.0/255.0, green: 60.0/255.0, blue: 53.0/255.0, alpha: 1.0),NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)])
            let string = NSAttributedString(string: " k/h")
            attributedText.append(string)
            speed.attributedText = attributedText
           
              //  speed.text = "\(truck.lastWaypoint.speed) k/h"
            }
            else{
                speed.text = ""
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        innerView.layer.cornerRadius = 8
        innerView.layer.masksToBounds = true
        
        shadowLayer.layer.masksToBounds = false
        shadowLayer.layer.shadowOffset = CGSize(width: 0.0, height: 0.4)
        shadowLayer.layer.shadowColor = UIColor.black.cgColor
        shadowLayer.layer.shadowOpacity = 0.23
        shadowLayer.layer.shadowRadius = 4
        
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}
