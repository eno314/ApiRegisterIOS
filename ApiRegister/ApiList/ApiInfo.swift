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
    let title: String
    
    // APIのURL
    let url: String
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
