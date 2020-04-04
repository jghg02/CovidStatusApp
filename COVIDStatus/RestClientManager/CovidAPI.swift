//
//  CovidAPI.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 04-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa

enum CovidAPI {
    static let baseURL = "https://corona.lmao.ninja/"
}


extension CovidAPI {
    static func getAllCountries(path: String) {
        CovidServices.requestdos(path: path) { result in
            print(result as Any)
        }
    }
}
