//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Fatih inan on 12/29/17.
//  Copyright © 2017 Fatih inan. All rights reserved.
//

import Foundation

class ToDoItem: NSObject, NSCoding
{
    var itemTitle: String
    var itemDesc: String
    var done: Bool

    
    public init(itemTitle:String, itemDesc: String)
    {
        self.itemTitle = itemTitle
        self.itemDesc = itemDesc
        self.done = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let title = aDecoder.decodeObject(forKey: "title") as? String{
            self.itemTitle = title

        }
        else{
            return nil
        }
        
        if let titleDesc = aDecoder.decodeObject(forKey: "desc") as? String{
            self.itemDesc = titleDesc
            
        }
        else{
            return nil
        }
        
        

        if aDecoder.containsValue(forKey: "done")
        {
            self.done = aDecoder.decodeBool(forKey: "done")
        }
        else{
            return nil
        }
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.itemTitle, forKey: "title")
        aCoder.encode(self.done, forKey: "done")
    }

}


extension Collection where Iterator.Element == ToDoItem
{

    private static func persistencePath() -> URL?
    {
        let url = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
        
        return url?.appendingPathComponent("todoitems.bin")
    }
    
    func writeToPersistence() throws
    {
        if let url = Self.persistencePath(), let array = self as? NSArray
        {
            let data = NSKeyedArchiver.archivedData(withRootObject: array)
            try data.write(to: url)
        }
        else
        {
            throw NSError(domain: "com.example.ToDoApp", code: 10, userInfo: nil)
        }
    }
    
    static func readFromPersistence() throws -> [ToDoItem]
    {
        if let url = persistencePath(), let data = (try Data(contentsOf: url) as Data?)
        {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [ToDoItem]
            {
                return array
            }
            else
            {
                throw NSError(domain: "com.example.MyToDo", code: 11, userInfo: nil)
            }
        }
        else
        {
            throw NSError(domain: "com.example.MyToDo", code: 12, userInfo: nil)
        }
    }
}



