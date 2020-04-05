//
//  CovidStatusPresenter.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 04-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa

protocol CovidStatusPresenterDelegate: NSObjectProtocol {
    func updateUI(data: [CovidCountry]?)
}

class CovidStatusPresenter {
    
    weak private var delegate: CovidStatusPresenterDelegate?
    var data: [CovidCountry]? = []
    
    init() {}
    
    func setViewDelegate(delegate: CovidStatusPresenterDelegate?) {
        self.delegate = delegate
    }
    
    func fetchAllCountries() {
        CovidServices.request(path: "countries") { (data, error) in
            self.delegate?.updateUI(data: data)
        }
    }
    

}
