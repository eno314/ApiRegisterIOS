//
//  ApiListStrage.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

// NSUserDefaultsのキー
private let KEY = "apiList"

class ApiListStrage: NSObject {
    
    // api情報を追加する
    class func add(url: String, title: String) -> Void {
        var apiList:[String] = []
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let savedData = userDefaults.objectForKey(KEY) as? NSData {
            var apiList = NSKeyedUnarchiver.unarchiveObjectWithData(savedData) as [String: String]
        }
        
        if let saved = userDefaults.objectForKey(KEY) as? [String] {
            apiList = saved
        }
        
        apiList.append(url + "," + title)
        
        // 保存
        userDefaults.setObject(apiList, forKey: KEY)
        userDefaults.synchronize()
    }
    
    // api情報一覧を取得する
    class func get() -> [ApiInfo] {
        if let saved = NSUserDefaults.standardUserDefaults().objectForKey(KEY) as? [String] {
            var apiList:[ApiInfo] = Array()
            for apiInfoString in saved {
                apiList.append(self.stringToApiInfo(apiInfoString))
            }
            return apiList
        } else {
            return Array()
        }
    }
    
    private class func stringToApiInfo(apiInfoString: String) -> ApiInfo {
        
        let splited = split(apiInfoString, { $0 == ","})
        
        let apiInfo = ApiInfo()
        apiInfo.url = splited[0]
        apiInfo.title = splited[1]
        
        return apiInfo
    }
}