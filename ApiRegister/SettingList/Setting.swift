//
//  Setting.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/08.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class Setting: NSObject {
    // display listview
    let title: String
    
    // setting api url
    let url: String
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
