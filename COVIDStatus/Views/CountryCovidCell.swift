//
//  CountryCovidCell.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 05-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa

class CountryCovidCell: NSTableCellView {

    @IBOutlet weak var img: NSImageCell!
    @IBOutlet weak var countryNameLabel: NSTextFieldCell!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    public func updateCell(data: CovidCountry?) {
        let imgURL = URL(string: (data?.countryInfo?.flag)!)
        img.load(url: imgURL!)
        
        countryNameLabel.title = (data?.country)!
    }
    
}


