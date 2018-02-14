//
//  ViewController.swift
//  Lists
//
//  Created by Matilda Stevenson on 9/2/18.
//  Copyright © 2018 Matilda Stevenson. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {

    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        tableView.rowHeight = 80
        tableView.separatorStyle = .none

    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // make cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none

        }
        else {
            cell.textLabel?.text = "No items added"
        }

        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    
    // method for actions when tableview cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            }
            catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        
        // what happens after selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new list item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }
                catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }

        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    
    //MARK: - Delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        if let itemForDeletion = self.todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
            }
            catch {
                print("Error deleting item, \(error)")
            }
        }
    }
    

    

}

//MARK: - Search Bar methods
// split up class functionality by delegate protocol
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //query database
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
               searchBar.resignFirstResponder()
            }

        }
    }
}

