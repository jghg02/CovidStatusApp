//
//  COVIDStatusTests.swift
//  COVIDStatusTests
//
//  Created by Josue Hernandez Gonzalez on 30-03-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import XCTest
@testable import COVIDStatus

class COVIDStatusTests: XCTestCase {

    func testInitVC() {
        let vc = StatusViewController()
        XCTAssertNotNil(vc)
    }
    
    func testViewControllerConformProtocol() {
        let vc = StatusViewController()
        XCTAssertNotNil(vc.presenter)
    }
    
    func testLoadViewControllerFromStoryBoard() {
        let story = NSStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(story)
        
        let vc = story.instantiateController(withIdentifier: "StatusViewController") as! StatusViewController
        XCTAssertNotNil(vc)
        XCTAssertTrue(vc.isMember(of:StatusViewController.self))

    }
    
    func testViewControllerLoadAllUI() {
        let story = NSStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateController(withIdentifier: "StatusViewController") as! StatusViewController
        
        XCTAssertNotNil(story)
        XCTAssertNotNil(vc)
        
        vc.loadView()
        
        XCTAssertNotNil(vc.textFieldCell)
        XCTAssertTrue(vc.textFieldCell.title == "COVID-19")
        XCTAssertNotNil(vc.loading)
        XCTAssertNotNil(vc.topBox)
        XCTAssertNotNil(vc.bottomBox)
        XCTAssertNotNil(vc.label)
        
    }
    
    func testViewControllerInitPresenter() {
        let story = NSStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateController(withIdentifier: "StatusViewController") as! StatusViewController
        
        XCTAssertNotNil(vc.presenter)
    }

}
