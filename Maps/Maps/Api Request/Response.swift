//
//  Response.swift
//  Maps
//
//  Created by vishalthakur on 09/12/21.
//

import Foundation

//Models for response

struct Truck: Codable{
    let breakdown: Bool
    let companyId: Int
    let createTime: Int
    let deactivated: Bool
    let durationInsideSite: Int
    let externalTruck: Bool
    let fuelSensorInstalled: Bool
    let id : Int
    let imeiNumber: String
    let lastRunningState: RunState
    let lastWaypoint: lastWaypoint
    let name: String
    let password: String
    let simNumber: String
    let trackerType: Int
    let transporterId: Int
    let truckNumber: String
    let truckSizeId: Int
    let truckTypeId: Int
    
    
}
struct RunState: Codable{
    let lat: Float
    let lng: Float
    let stopNotficationSent: Int
    let stopStartTime: Int
    let truckId: Int
    let truckRunningState: Int
}
struct lastWaypoint: Codable{
    let accuracy: Int
    let batteryLevel: Int
    let batteryPower: Bool
    let bearing: Int
    let createTime: Int
    let fuelLevel: Int
    let id: Int
    let ignitionOn: Bool
    let lat: Float
    let lng: Float
    let odometerReading: Float
    let speed: Float
    let truckId: Int
    let updateTime: Int
}
struct Response: Codable{
    let responseCode: Code
    let data: [Truck]
}
struct Code: Codable{
    let message: String
    let responseCode: Int
}

