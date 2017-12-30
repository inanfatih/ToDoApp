//
//  ViewController.swift
//  ToDoApp
//
//  Created by Fatih inan on 12/29/17.
//  Copyright © 2017 Fatih inan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private var toDoItems = [ToDoItem]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell_todo", for: indexPath)
    
    if indexPath.row < toDoItems.count
    {
        let item = toDoItems[indexPath.row]
        cell.textLabel?.text = item.itemTitle
        
        let accessory: UITableViewCellAccessoryType=item.done ? .checkmark : .none
        cell.accessoryType = accessory
    }
    
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < toDoItems.count
        {
            let item = toDoItems[indexPath.row]
            item.done = !item.done
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "ToDo App"
        //        tableView.backgroundColor = UIColor.red
        tableView.tintColor  = UIColor.red
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.didTapAddItemButton(_:)))
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)),
            name: NSNotification.Name.UIApplicationDidEnterBackground,
            object: nil)
        
        do
        {

            self.toDoItems = try [ToDoItem].readFromPersistence()
        }
        catch let error as NSError
        {
            if error.domain == NSCocoaErrorDomain && error.code == NSFileReadNoSuchFileError
            {
                NSLog("No persistence file found, not necesserially an error...")
            }
            else
            {
                let alert = UIAlertController(
                    title: "Error",
                    message: "Could not load the to-do items!",
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                NSLog("Error loading from persistence: \(error)")
            }
        }
    }

        
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem)
    {
     let alert = UIAlertController(
        title:"New To Do Item",
        message: "Insert the title of the new to do item",
        preferredStyle: .alert
        )
        
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text
            {
                self.addNewToDoItem(title: title)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNewToDoItem (title:String){
    
        let newIndex = toDoItems.count
        
        toDoItems.append(ToDoItem(itemTitle: title, itemDesc: title))
        
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < toDoItems.count
        {
            toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    
    @objc public func applicationDidEnterBackground(_ notification: NSNotification)
    {
        do{
            try toDoItems.writeToPersistence()
        }
        catch let error
        {
            NSLog("Error writing to persistence: \(error)")
            
        }
        
    }
    
    
}

