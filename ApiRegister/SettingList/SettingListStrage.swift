//
//  SettingListStrage.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/08.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

// NSUserDefaults's key
private let KEY = "SettingList"

class SettingListStrage: NSObject {
    
    class func add(url: String, title: String) -> Void {
        var settingList:[String] = []
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let saved = userDefaults.objectForKey(KEY) as? [String] {
            settingList = saved
        }
        
        settingList.append(title + "," + url)
        
        // save
        userDefaults.setObject(settingList, forKey: KEY)
        userDefaults.synchronize()
    }
    
    class func get() -> [Setting] {
        if let saved = NSUserDefaults.standardUserDefaults().objectForKey(KEY) as? [String] {
            var settingList:[Setting] = Array()
            for setting in saved {
                settingList.append(self.stringToSetting(setting))
            }
            return settingList
        } else {
            return Array()
        }
    }
    
    private class func stringToSetting(settingString: String) -> Setting {
        
        let splited = split(settingString, { $0 == ","})
        let setting = Setting(title: splited[0], url: splited[1])
        
        return setting
    }
}
