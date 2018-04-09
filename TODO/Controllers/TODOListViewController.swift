//
//  ViewController.swift
//  TODO
//
//  Created by Ren Cummings on 4/7/18.
//  Copyright © 2018 Ren Cummings. All rights reserved.
//

import UIKit


class TODOListViewController: UITableViewController {
    
   var itemArr = [Item]()
   let defaults = UserDefaults.standard
   let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    //MARK - Tableview Datasource Methods:
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItmCell", for: indexPath)
        let item = itemArr[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArr[indexPath.row].done = !itemArr[indexPath.row].done
        saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new TODO item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //add item functionality
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArr.append(newItem)
            self.saveItem()
            
        }
        alert.addAction(action)
        alert.addTextField { (alertTextInput) in
            alertTextInput.placeholder = "create new item"
            textField = alertTextInput
        }
        present(alert, animated: true, completion: nil)
    }
    func saveItem() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArr)
            try data.write(to: dataPath!)
        } catch {
            print("Error: encoding item array, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataPath!) {
        
            let decoder = PropertyListDecoder()
            do {
            itemArr = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error: Decode \(error)")
            }
            
        }
    
    }
    
}

