//
//  CoreDataTVC.swift
//  IOS Contact App Example For Facebook User
//
//  Created by Craig Spell on 11/10/17.
//  Copyright © 2017 Craig Spell. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext = CDManager.shared.persistentContainer.viewContext

    ///We use a generic NSManagedObject so here so that our subclasses can be more diverse
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? = nil {

        didSet{
            fetchedResultsController!.delegate = self

            do {
                try fetchedResultsController!.performFetch()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    /// Abstract method used by subclass to layout the cell.
    ///
    /// - Parameters:
    ///   - cell: The UITableViewCell dequed for insertion into the table view.
    ///   - object: The fetched results controllers corresponding object for the cells index path.
    func configureCell(_ cell: UITableViewCell, withManagedObject object: NSManagedObject) {
        //Abstract Method Called For Subclasses
    }

    ///Abstract method used by the subclass to build and assign a value to our fetchedResultsController property.
    func setupFetchedResultsController() {
        //Abstract to be handled by subclasses
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftItemsSupplementBackButton = true

        if fetchedResultsController == nil {
            setupFetchedResultsController()
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {

        return fetchedResultsController?.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController?.sections![section]

        return sectionInfo?.numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = fetchedResultsController?.sections![section]
        return sectionInfo?.name ?? ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       
        if let object = fetchedResultsController?.object(at: indexPath) {
            //our object is a Contact entity so we can use it and our reusable cell to display
            //the information in our table view. keep in mind configureCell(_:,withContact:) is
            //an abstract method that must be implemented by our subclass.
            configureCell(cell, withManagedObject: object as! NSManagedObject)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            let context = fetchedResultsController?.managedObjectContext
            context?.delete(fetchedResultsController!.object(at: indexPath) as! NSManagedObject)
            
            do {

                try context?.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {

        switch type {

        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)

        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {

        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            //update the cells information for the updated object
            configureCell(tableView.cellForRow(at: indexPath!)!, withManagedObject: anObject as! NSManagedObject)
        case .move:
            //populate the cell if needed and move to the new indexpath
            configureCell(tableView.cellForRow(at: indexPath!)!, withManagedObject: anObject as! NSManagedObject)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
