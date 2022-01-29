//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    
    var itemArray=[ItemModel]()
   
//    let dataFilePath = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemOrange
        print(FileManager.default.urls(for:.documentDirectory, in: .userDomainMask))
        loadItems()

    }
    //MARK:- Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.checked ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        context.delete(itemArray[indexPath.row])
        
        itemArray.remove(at: indexPath.row)
       
        saveItems()
        self.tableView.reloadData()
        
        
//        itemArray[indexPath.row].checked != itemArray[indexPath.row].checked
//
//        if tableView.cellForRow(at:indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at:indexPath)?.accessoryType = .none
//        }
//        else {
//            tableView.cellForRow(at:indexPath)?.accessoryType = .checkmark
//        }
//
      
        
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//MARK:- add new item

    @IBAction func addButtonConnected(_ sender: UIBarButtonItem) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
   
            let newItem = ItemModel(context: self.context)
        
            newItem.title=textField.text!
            newItem.checked=false
       
            self.itemArray.append(newItem)
            
            self.saveItems()
            self.tableView.reloadData()
        
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
           textField=alertTextField
        }
        alert.addAction(action)
        
        present(alert,animated:true,completion:nil)
      
    }
    
//MARK:- manipulate items
    
    func saveItems(){
        do{
          try context.save()
            
        } catch{
           print("Error saving context\(error)")
        }
        
    }
    
//MARK:- load items
    
    func loadItems(){
        let request:NSFetchRequest<ItemModel> = ItemModel.fetchRequest()
       do
            { itemArray = try context.fetch(request)
            } catch{
                print ("Error fetching data from context\(error)")
            }
        }

}
