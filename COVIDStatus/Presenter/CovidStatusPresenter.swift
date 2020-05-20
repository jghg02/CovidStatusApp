//
//  CovidStatusPresenter.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 04-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa
import Combine

protocol CovidStatusPresenterDelegate: NSObjectProtocol {
    func updateUI(data: [CovidCountry]?)
    func updateHeaderInfo(data: CovidTotal?)
}

class CovidStatusPresenter {
    
    weak var delegate: CovidStatusPresenterDelegate?
    var data: [CovidCountry]? = []
    
    init() {}
    
    func setViewDelegate(delegate: CovidStatusPresenterDelegate?) {
        self.delegate = delegate
    }
    
    func fetchAllCountries() {
        CovidServices.request(path: "countries") { (data, error) in
            // Sort countrys by quantity cases
            let sortedData = data?.sorted{ (lhs: CovidCountry, rhs: CovidCountry) -> Bool in
                return lhs.cases > rhs.cases
            }
            self.delegate?.updateUI(data: sortedData)
        }
    }
    
    func fetchTotalCases() {
        CovidServices.allCases { (data, error) in
            self.delegate?.updateHeaderInfo(data: data)
        }
    }
    
    func fetchWithOutCombineAllCountries() {
        let provider: CovidAPIProvider! = CovidAPI()
        provider.fetchDataFromServer {
            switch $0 {
            case .failure(_):
                print("Error...SACUDELO...")
            case let .success(response):
                print("XXXXXX \(response)")
            }
        }
    }
    
    func fetchWithCombine() {
        var publisher = [AnyCancellable]()
        let provider: CovidAPIProvider! = CovidAPI()
        provider.fetchDataFromServer()
            .map{ $0.todayCases }
            .sink(receiveCompletion: { _ in print("ERROR...")}, receiveValue: { print($0 as Any) })
            .store(in: &publisher)
        
    }
    

}
