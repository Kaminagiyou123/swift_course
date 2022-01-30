//
//  CategoryViewController.swift
//  Todoey
//
//  Created by ran you on 1/30/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class CategoryViewController: UITableViewController{
    
    var categoryArray=[Category]()
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemOrange
        
        loadItems()
        
        tableView.rowHeight=80.0

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        let category = categoryArray[indexPath.row]
      
        cell.textLabel?.text = category.name
        
        return cell
    }
    
  
    
    //MARK:- data view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath  = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
  
    
    
    //MARK:- add new categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
            
            var textField=UITextField()
            
            let alert=UIAlertController(title: "Add new Todo category", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Add category", style: .default) { action in
                
    //   save data to database
                let newCat = Category(context: self.context)

                newCat.name=textField.text!
                self.categoryArray.append(newCat)
                self.saveItems()
                self.tableView.reloadData()
            
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder = "Create new category"
               textField=alertTextField
            }
            alert.addAction(action)
            
            present(alert,animated:true,completion:nil)
          
        }
        
    //MARK:- save items
        
        func saveItems(){
            do{
              try context.save()
                
            } catch{
               print("Error saving context\(error)")
            }
            
        }
        
    //MARK:- load items
        
        func loadItems(with request:NSFetchRequest<Category> = Category.fetchRequest()){
       
           do
                { categoryArray = try context.fetch(request)
                } catch{
                    print ("Error fetching data from context\(error)")
                }
            }

    
    //MARK:- Tableview delegate methods
}
extension CategoryViewController:SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
           
            context.delete(self.categoryArray[indexPath.row])
            categoryArray.remove(at: indexPath.row)
    
            self.saveItems()
           
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-Icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}
