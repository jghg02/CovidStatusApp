//
//  StatusViewController.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 01-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa
import Foundation

class StatusViewController: NSViewController, CovidStatusPresenterDelegate {

    var presenter = CovidStatusPresenter()
    var allCountries: [CovidCountry]? = []
    
    @IBOutlet weak var loading: NSProgressIndicator!{
        didSet {
            self.loading.appearance = NSAppearance(named: .darkAqua)
        }
    }
    @IBOutlet weak var topBox: NSBox!
    @IBOutlet weak var bottomBox: NSBox!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var textFieldCell: NSTextFieldCell! {
        didSet {
            self.textFieldCell.backgroundColor = .clear
        }
    }
    @IBOutlet weak var collectionView: NSCollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldCell.title = "COVID-19"
        loading.startAnimation(self)
        presenter.setViewDelegate(delegate: self)
        presenter.fetchAllCountries()
        presenter.fetchTotalCases()
        
    }
    
    func updateUI(data: [CovidCountry]?) {
        DispatchQueue.main.async {
            self.allCountries = data
            self.collectionView.reloadData()
            self.loading.isHidden = true
        }
    }
    
    func updateHeaderInfo(data: CovidTotal?) {
        let casesFormater = data?.cases?.formattedWithSeparator
        DispatchQueue.main.async {
            self.textFieldCell.title = "Total Cases: \(casesFormater!)"
        }
    }
    
}


extension StatusViewController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allCountries!.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let row = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "RowCell"), for: indexPath)
        
        guard let collectionViewItem = row as? RowCell else { return row }
        collectionViewItem .createRow(country: self.allCountries![indexPath.item])
        
        collectionViewItem.view.wantsLayer = true
        
        return row
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
