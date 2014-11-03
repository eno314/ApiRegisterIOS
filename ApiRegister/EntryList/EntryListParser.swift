//
//  EntryListParser.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/02.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

private let ELEMENT_ENTRIES = "entries"
private let ELEMENT_TITLE = "title"
private let ELEMENT_URL = "url"
private let ELEMENT_IMAGE = "image"

class EntryListParser: NSObject {
   
    func parse(json: AnyObject) -> Array<Entry>? {
        if let result = json as? Dictionary<String, Array<Dictionary<String, String>>> {
            return parseRoot(result[ELEMENT_ENTRIES])
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
        
        if entryDictionary[ELEMENT_TITLE] != nil {
            entry.title = entryDictionary[ELEMENT_TITLE]
        }
        
        if entryDictionary[ELEMENT_URL] != nil {
            entry.url = entryDictionary[ELEMENT_URL]
        }
        
        if entryDictionary[ELEMENT_IMAGE] != nil {
            entry.image = entryDictionary[ELEMENT_IMAGE]
        }
        
        return entry
    }
}
