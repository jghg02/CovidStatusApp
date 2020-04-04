//
//  CovidServices.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 03-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class CovidServices {

    class public func requestdos(path: String, method: RequestMethod = .get, completion: @escaping (NSArray?) -> Void) {
        let url = URL(string: CovidAPI.baseURL + path)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray
                print(json)
                completion(json)
            } catch let error as NSError {
                print(error)
                completion(nil)
            }
        })
        task.resume()
    }
    
    
    class public func request(path: String, method: RequestMethod = .get) {
        let url = URL(string: CovidAPI.baseURL + path)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response as Any)
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                print(json)
            } catch {
                print("error")
            }
        })

        task.resume()
    }
    
    
}
