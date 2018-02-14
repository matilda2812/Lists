//
//  Item.swift
//  Lists
//
//  Created by Matilda Stevenson on 13/2/18.
//  Copyright © 2018 Matilda Stevenson. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
