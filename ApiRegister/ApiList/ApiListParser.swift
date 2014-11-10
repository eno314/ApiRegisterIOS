//
//  ApiListParser.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/11.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

private let ELEMENT_ENTRIES = "entries"
private let ELEMENT_LIST_NAME = "listName"
private let ELEMENT_API_LIST = "apiList"
private let ELEMENT_NAME = "name"
private let ELEMENT_URL = "url"

class ApiListParser: NSObject {
   
    func parse(json: AnyObject) -> ApiList? {
        if let result = json as? Dictionary<String, Dictionary<String, AnyObject>> {
            return parseRoot(result[ELEMENT_ENTRIES])
        } else {
            println("root is not Dictionary<String, Dictionary>")
            return nil
        }
    }
    
    private func parseRoot(entriesArray: Dictionary<String, AnyObject>?) -> ApiList? {
        if entriesArray == nil {
            println("entries is nothing !!!")
            return nil
        }
        
        let apiList: ApiList = ApiList()
        
        if let listName = entriesArray![ELEMENT_LIST_NAME] as? String {
            apiList.listName = listName
        } else {
            println("failed get listName")
            return nil
        }
        
        if let list = entriesArray![ELEMENT_API_LIST] as? Array<Dictionary<String, String>> {
            apiList.list = parseApiList(list)
        } else {
            println("failed get apiList")
            return nil
        }
        
        if apiList.isValid() {
            return apiList
        } else {
            return nil
        }
    }
    
    private func parseApiList(apiInfoArray: Array<Dictionary<String, String>>) -> Array<ApiInfo>? {
        
        var apiInfoList = Array<ApiInfo>()
        
        for dictionary: Dictionary<String, String> in apiInfoArray {
            let apiInfo = parseApiInfo(dictionary)
            
            if (!apiInfo.isValid()) {
                return nil
            }
            apiInfoList.append(apiInfo)
        }
        
        return apiInfoList
    }
    
    private func parseApiInfo(apiInfoDictionary: Dictionary<String, String>) -> ApiInfo {
        let apiInfo: ApiInfo = ApiInfo()
        
        if apiInfoDictionary[ELEMENT_NAME] != nil {
            apiInfo.title = apiInfoDictionary[ELEMENT_NAME]
        }
        
        if apiInfoDictionary[ELEMENT_URL] != nil {
            apiInfo.url = apiInfoDictionary[ELEMENT_URL]
        }
        
        return apiInfo
    }
}
