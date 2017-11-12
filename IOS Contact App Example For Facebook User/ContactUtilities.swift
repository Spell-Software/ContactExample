//
//  ContactUtilities.swift
//  IOS Contact App Example For Facebook User
//
//  Created by Craig Spell on 11/10/17.
//  Copyright © 2017 Craig Spell. All rights reserved.
//

import CoreData

extension Contact {

    ///A calculated property used for section titles to keep sections displayed by the first letter of our contacts.
    var firstLetter : String? {
        
        get{
            if let character = self.name?.characters.first{
                return String(character)
            }
            return nil
        }
    }
}
