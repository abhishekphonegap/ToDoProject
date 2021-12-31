//
//  ViewController.swift
//  ToDoTasks
//
//  Created by Abhishek Dangwal on 26/12/21.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    var dataFilePath = URL(string: "")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        //print(dataFilePath)
        loadData()
        
    }

    //MARK: - Table View DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblListViewCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].checked == true ? .checkmark : .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selected Row is \(indexPath.row)")
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].checked = !(itemArray[indexPath.row].checked)
        addData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Itesm
    
    @IBAction func addToDoItem(_ sender: UIBarButtonItem) {
        
        var txtField = UITextField()
        let newItem = Item()

        let alert  = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            if txtField.text!.count>0 {
                newItem.title = txtField.text!
                self.itemArray.append(newItem)
                self.addData()
                
            }
        }
        alert.addTextField { textField in
            textField.placeholder = "Write a new Item to add."
            txtField = textField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func addData() {
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
            self.tableView.reloadData()
        }
        catch{
            print("Value is not added..\(error)")
        }
    }
    //change
    func loadData() {
        
        let dataItems = try? Data(contentsOf: dataFilePath!)
        do{
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: dataItems!)
            }catch {
                print("decoder error is \(error)")
            }
        }

    }
    
}
