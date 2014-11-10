//
//  ApiInfo.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class ApiInfo: NSObject {
    
    // リストに表示するためのタイトル
    var title: String?
    
    // APIのURL
    var url: String?
    
    override init() {
        super.init()
    }
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
        
        super.init()
    }
    
    func isValid() -> Bool {
        if self.title == nil {
            return false
        }
        
        if self.url == nil {
            return false
        }
        
        return true
    }
}
