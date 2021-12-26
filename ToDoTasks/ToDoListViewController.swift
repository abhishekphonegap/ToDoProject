//
//  ViewController.swift
//  ToDoTasks
//
//  Created by Abhishek Dangwal on 26/12/21.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Abhishek", "Dangwal", "Abhishek"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }

    //MARK: - Table View DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblListViewCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected Row is \(itemArray[indexPath.row])...")
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Itesm
    
    @IBAction func addToDoItem(_ sender: UIBarButtonItem) {
        
        var txtField = UITextField()
        
        let alert  = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            if txtField.text!.count>0 {
                self.itemArray.append(txtField.text!)
                self.tableView.reloadData()
            }
        }
 
        alert.addTextField { textField in
            textField.placeholder = "Write a new Item to add."
            txtField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

