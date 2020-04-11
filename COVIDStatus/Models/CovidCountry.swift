//
//  CovidCountry.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 01-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Foundation

struct CovidCountry: Codable {

    let country: String?
    let countryInfo: CovidCountryInfo?
    let cases: Int?
    let todayCases: Int?
    let deaths: Int?
    let todayDeaths: Int?
    let recovered: Int?
    let active: Int?
    let critical: Int?
    let casesPerOneMillion: Double?
    let deathsPerOneMillion: Double?

}

struct CovidCountryInfo: Codable {
    let _id: Int?
    let iso2: String?
    let iso3: String?
    let lat: Double?
    let long: Double?
    let flag: String?
}
