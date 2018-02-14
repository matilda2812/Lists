//
//  Category.swift
//  Lists
//
//  Created by Matilda Stevenson on 13/2/18.
//  Copyright © 2018 Matilda Stevenson. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
