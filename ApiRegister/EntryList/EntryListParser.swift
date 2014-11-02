//
//  EntryListParser.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/02.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class EntryListParser: NSObject {
   
    func parse(json:AnyObject) {
        if let result = json as? Dictionary<String, Array<Dictionary<String, String>>> {
            println(result)
        }
    }
}
