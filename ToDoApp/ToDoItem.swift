//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Fatih inan on 12/29/17.
//  Copyright © 2017 Fatih inan. All rights reserved.
//

import Foundation

class ToDoItem{
    var itemTitle: String
    var itemDesc: String
    var done: Bool

    
    public init(itemTitle:String, itemDesc: String)
    {
        self.itemTitle = itemTitle
        self.itemDesc = itemDesc
        self.done = false
    }
    

}

extension ToDoItem
{
    public class func getMockData() -> [ToDoItem]
    {
        return [
            ToDoItem(itemTitle: "Milk", itemDesc: "milk description"),
            ToDoItem(itemTitle: "Chocolate", itemDesc: "chocolate description")
        ]
    }
}
