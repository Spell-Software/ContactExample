//
//  ContactsTVC.swift
//  IOS Contact App Example For Facebook User
//
//  Created by Craig Spell on 11/10/17.
//  Copyright © 2017 Craig Spell. All rights reserved.
//

import UIKit
import CoreData

class ContactsTVC: CoreDataTVC {

    override func configureCell(_ cell: UITableViewCell, withManagedObject object: NSManagedObject){
        super.configureCell(cell, withManagedObject: object)

        let contact = object as! Contact

        cell.textLabel!.text = contact.name
        cell.detailTextLabel?.text = contact.number

    }
    
    override func setupFetchedResultsController(){
        super.setupFetchedResultsController()

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Contact.fetchRequest()
        fetchRequest.predicate = nil
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20

        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor.init(key: "name",
                                                   ascending: true,
                                                   selector: #selector(NSString.caseInsensitiveCompare(_:)))
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "firstLetter", cacheName: nil)
    }
}
