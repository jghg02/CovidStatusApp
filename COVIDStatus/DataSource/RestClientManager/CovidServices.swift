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
    
    static let baseURL = "https://corona.lmao.ninja/"
    
    class public func request(path: String, method: RequestMethod = .get, completionHandler: @escaping ([CovidCountry]?, Error?) -> Void) {
        let url = URL(string: self.baseURL + path)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray
                let json = try JSONDecoder().decode([CovidCountry].self, from: data)
                completionHandler(json, nil)
            } catch let error as NSError {
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    class public func allCases(path: String = "all", method: RequestMethod = .get, completionHandler: @escaping (CovidTotal?, Error?) -> Void) {
        let url = URL(string: self.baseURL + path)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray
                let json = try JSONDecoder().decode(CovidTotal.self, from: data)
                completionHandler(json, nil)
            } catch let error as NSError {
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
}
