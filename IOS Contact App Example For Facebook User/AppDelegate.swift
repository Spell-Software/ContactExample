//
//  AppDelegate.swift
//  IOS Contact App Example For Facebook User
//
//  Created by Craig Spell on 11/10/17.
//  Copyright © 2017 Craig Spell. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationWillTerminate(_ application: UIApplication) {
        CDManager.shared.saveContext()
    }
}

