//
//  AddContactsVC.swift
//  IOS Contact App Example For Facebook User
//
//  Created by Craig Spell on 11/10/17.
//  Copyright © 2017 Craig Spell. All rights reserved.
//

import UIKit
import CoreData

class AddContactsVC: UIViewController {

    ///A property representing the shared singleton instance of the manager of our core data stack
    let cdmanager = CDManager.shared

    //UITextFields set from storyboard
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    
    ///The target action associated with the add contact button set from storyboard
    @IBAction func addAction() {

        //if either of our text fields return nil for the text we replace it with an empty string.
        let name = self.nameField.text ?? ""
        let number = self.numberField.text ?? ""

        //If the user failed to enter text in both the text fields we'll just do nothing.
        if (name != "") && (number != "") {

            //Because we are creating a new entity we simple call the convience init against our view context.
            let newContact = Contact(context: cdmanager.persistentContainer.viewContext)
            //populate our properties we want to store.
            newContact.name = self.nameField.text
            newContact.number = self.numberField.text
            //save our new object
            //saving is not neccissarily required, but for demonstration and debugging purposes we will here.
            //we also save in our app delegate so this might be a little redundant if you're not setting break points.
            CDManager.shared.saveContext()

            //clear the text from our text field so the user knows something occurred and also to prepare for more text.
            self.nameField.text = ""
            self.numberField.text = ""

            //dismiss keyboard if showing and unselect the text fields
            self.nameField.resignFirstResponder()
            self.numberField.resignFirstResponder()
        }
    }

    //if nothing else is required we could simply do this in storyboard
    @IBAction func showAction() {
        //show the contacts table view controller
        performSegue(withIdentifier: "showContacts", sender: nil)
    }
}





























