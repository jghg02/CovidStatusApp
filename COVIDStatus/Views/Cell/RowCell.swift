//
//  RowCell.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 07-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa

class RowCell: NSCollectionViewItem {

    
    @IBOutlet weak var countryName: NSTextFieldCell! {
        didSet {
            self.countryName.backgroundColor = .clear
        }
    }
    @IBOutlet weak var totalCases: NSTextFieldCell!
    @IBOutlet weak var flag: NSImageCell! {
        didSet {
            self.flag.imageScaling = .scaleAxesIndependently
            self.flag.isBordered = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func createRow(country: CovidCountry?) {
        let imgURL = URL(string: (country?.countryInfo?.flag)!)
        flag.load(url: imgURL!)
        countryName.title = (country?.country)!
        totalCases.title = "\(country?.todayCases ?? 0)"
    }
    
}
