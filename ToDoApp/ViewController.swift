//
//  ViewController.swift
//  ToDoApp
//
//  Created by Fatih inan on 12/29/17.
//  Copyright © 2017 Fatih inan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private var toDoItems = ToDoItem.getMockData()
    
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
}

