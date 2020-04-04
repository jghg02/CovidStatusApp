//
//  StatusViewController.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 01-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa

class StatusViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CovidAPI.getAllCountries(path: "countries")
        
        
    }
    

    
}


extension StatusViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> StatusViewController {
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    let identifier = NSStoryboard.SceneIdentifier("StatusViewController")
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? StatusViewController else {
      fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
