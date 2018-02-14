//
//  AppDelegate.swift
//  Lists
//
//  Created by Matilda Stevenson on 9/2/18.
//  Copyright © 2018 Matilda Stevenson. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do {
            _ = try Realm()
        }
        catch {
            print("Error initialising new Realm, \(error)")
        }

        return true
    }


}
