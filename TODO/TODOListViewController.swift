//
//  ViewController.swift
//  TODO
//
//  Created by Ren Cummings on 4/7/18.
//  Copyright © 2018 Ren Cummings. All rights reserved.
//

import UIKit
var itemArr = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

class TODOListViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK - Tableview Datasource Methods:
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItmCell", for: indexPath)
        cell.textLabel?.text = itemArr[indexPath.row]
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new TODO item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //add item functionality
            itemArr.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextInput) in
            alertTextInput.placeholder = "create new item"
            textField = alertTextInput
            

            
        }
        present(alert, animated: true, completion: nil)
        
    }
    
}

