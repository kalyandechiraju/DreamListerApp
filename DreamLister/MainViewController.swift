//
//  MainViewController.swift
//  DreamLister
//
//  Created by Kalyan Dechiraju on 27/03/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    var fetchResultsController: NSFetchedResultsController<Item>!
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //generateTestData()
        attemptFetch()
    }
    
    func generateTestData() {
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 1800
        item.details = "This is the computer to own."
        
        let item2 = Item(context: context)
        item2.title = "iPhone 7"
        item2.price = 799
        item2.details = "The phone to get next."
        
        let item3 = Item(context: context)
        item3.title = "Apple Watch"
        item3.price = 399
        item3.details = "The device that completes Apple ecosystem."
        appDelegate.saveContext()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: IndexPath) {
        let item = fetchResultsController.object(at: indexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchResultsController.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Standard height for each cell
        return 150
    }

    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.fetchResultsController = controller
        do {
            try controller.performFetch()
        } catch {
            let err = error as NSError
            print("\(err)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let index = newIndexPath {
                tableView.insertRows(at: [index], with: .fade)
            }
            break
        case .delete:
            if let index = indexPath {
                tableView.deleteRows(at: [index], with: .fade)
            }
            break
        case .update:
            if let index = indexPath {
                let cell = tableView.cellForRow(at: index) as! ItemCell
                // Update table cell
                configureCell(cell: cell, indexPath: index)
            }
            break
        case .move:
            if let index = indexPath {
                tableView.deleteRows(at: [index], with: .fade)
            }
            if let index = newIndexPath {
                tableView.insertRows(at: [index], with: .fade)
            }
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let items = fetchResultsController.fetchedObjects, items.count > 0 {
            performSegue(withIdentifier: "itemDetailSegue", sender: items[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetailSegue" {
            if let destination = segue.destination as? ItemDetailsViewController {
                if let item = sender as? Item {
                    destination.itemToLoad = item
                }
            }
        }
    }

}

