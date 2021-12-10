//
//  RequestManager.swift
//  Maps
//
//  Created by vishalthakur on 09/12/21.
//

import Foundation
 

let api = RequestManager.shared
class RequestManager {
    static let shared = RequestManager()
    
    
    func getData(completion: @escaping (([Truck]) -> ())) {
    let url = URL(string: api_url)!


       //create the session object
       let session = URLSession.shared

       //now create the URLRequest object using the url object
       let request = URLRequest(url: url)

        var trucks: [Truck] = []
       //create dataTask using the session object to send data to the server
       let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

           guard error == nil else {
               return
           }

           guard let data = data else {
               return
           }
           var result : Response?
          do {
             //create json object from data
              
                      
               result = try JSONDecoder().decode(Response.self, from: data)
              if let result = result{
                  trucks = result.data
                  completion(trucks)
              }
              else{
                  print("Failed to parse")
              }
             return
          } catch{
            print("Error: \(error)")
          }
       })

       task.resume()
    }
}
