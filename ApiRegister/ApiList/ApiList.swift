//
//  ApiList.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/11.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class ApiList: NSObject {
   
    var listName: String?
    
    var list: Array<ApiInfo>?
    
    func isValid() -> Bool {
        if listName == nil {
            return false
        }
        
        if list == nil {
            return false
        }
        
        if list!.count == 0 {
            return false
        }
        
        return true
    }
}
