//
//  ViewController.swift
//  Lists
//
//  Created by Matilda Stevenson on 9/2/18.
//  Copyright © 2018 Matilda Stevenson. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Buy eggs", "source hitman", "build wall"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // make cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        // populate cell with text
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    // MARK - Tableview Delegate Methods
    
    // method for actions when tableview cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        // grab reference to particular cell (at indexpath) and add/remove checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // what happens after selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

