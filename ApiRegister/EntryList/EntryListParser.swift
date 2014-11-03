//
//  EntryListParser.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/02.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class EntryListParser: NSObject {
   
    func parse(json: AnyObject) -> Array<Entry>? {
        if let result = json as? Dictionary<String, Array<Dictionary<String, String>>> {
            return parseRoot(result["entries"])
        } else {
            return nil
        }
    }
    
    private func parseRoot(entriesArray: Array<Dictionary<String, String>>?) -> Array<Entry>? {
        if entriesArray == nil {
            return nil
        }
        
        var entryList: Array<Entry> = Array<Entry>()
        
        for entryDictionary: Dictionary<String, String> in entriesArray! {
            let entry: Entry = parseEntry(entryDictionary)
            
            if (!entry.isValid()) {
                return nil
            }
            
            entryList.append(entry)
        }
        
        return entryList
    }
    
    private func parseEntry(entryDictionary: Dictionary<String, String>) -> Entry {
        let entry: Entry = Entry()
        
        if entryDictionary["title"] != nil {
            entry.title = entryDictionary["title"]
        }
        
        if entryDictionary["url"] != nil {
            entry.url = entryDictionary["url"]
        }
        
        if entryDictionary["image"] != nil {
            entry.image = entryDictionary["image"]
        }
        
        return entry
    }
}
