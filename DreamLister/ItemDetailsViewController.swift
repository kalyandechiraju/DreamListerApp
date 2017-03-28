//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Kalyan Dechiraju on 28/03/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titleTextView: CustomTextField!
    @IBOutlet weak var priceTextView: CustomTextField!
    @IBOutlet weak var detailsTextView: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    
    var stores = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationItem = self.navigationController?.navigationBar.topItem {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        storePicker.dataSource = self
        storePicker.delegate = self
        
        // insertStores()
        fetchStores()
    }
    
    func insertStores() {
        let store = Store(context: context)
        store.name = "Amazon"
        let store2 = Store(context: context)
        store2.name = "Flipkart"
        let store3 = Store(context: context)
        store3.name = "Snapdeal"
        let store4 = Store(context: context)
        store4.name = "Reliance Digital"
        let store5 = Store(context: context)
        store5.name = "BestBuy"
        let store6 = Store(context: context)
        store6.name = "Paytm"
        appDelegate.saveContext()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Udpdate model
    }
    
    func fetchStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let err = error as NSError
            print("\(err)")
        }
    }

}
