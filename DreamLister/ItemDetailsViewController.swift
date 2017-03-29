//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Kalyan Dechiraju on 28/03/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextView: CustomTextField!
    @IBOutlet weak var priceTextView: CustomTextField!
    @IBOutlet weak var detailsTextView: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var thumbnail: UIImageView!
    
    
    var stores = [Store]()
    var itemToLoad: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationItem = self.navigationController?.navigationBar.topItem {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        storePicker.dataSource = self
        storePicker.delegate = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //insertStores()
        fetchStores()
        if itemToLoad != nil {
            loadItem()
        }
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
        // Udpdate
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
    
    @IBAction func saveItem(_ sender: UIButton) {
        var item: Item!
        
        if itemToLoad == nil {
            item = Item(context: context)
        } else {
            item = itemToLoad
        }
        
        let image = Image(context: context)
        image.image = thumbnail.image
        
        item.toImage = image
        
        if let title = titleTextView.text {
            item.title = title
        }
        if let price = priceTextView.text {
            item.price = (price as NSString).doubleValue
        }
        if let detail = detailsTextView.text {
            item.details = detail
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        appDelegate.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItem() {
        if let item = itemToLoad {
            titleTextView.text = item.title
            priceTextView.text = "\(item.price)"
            detailsTextView.text = item.details
            thumbnail.image = item.toImage?.image as? UIImage
            if let store = item.toStore {
                for s in stores {
                    if s.name == store.name {
                        storePicker.selectRow(stores.index(of: s)!, inComponent: 0, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        if itemToLoad != nil {
            context.delete(itemToLoad!)
            appDelegate.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imagePickerAction(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbnail.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}
