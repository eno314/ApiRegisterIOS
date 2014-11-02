//
//  EntryListRequest.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit
import Alamofire

class EntryListRequest: NSObject {
    // リクエスト先のURL
    private let mRequestUrl: String
    
    // APIのパース結果を受け取った時のコールバック
    private let mOnReceiveEntryList: ([Entry] -> Void)?
    
    // エラー時のコールバック
    private let mOnRequestFaild: (() -> Void)?
    
    // Builder専用のコンストラクタ
    private init(builder: EntryListRequest.Builder) {
        mRequestUrl = builder.mRequestUrl
        mOnReceiveEntryList = builder.mOnReceiveEntryList
        mOnRequestFaild = builder.mOnRequestFaild
    }
    
    func execute() {
        Alamofire.request(.GET, mRequestUrl).responseJSON(onResponse)
    }
    
    private func onResponse(request: NSURLRequest, response: NSHTTPURLResponse?, json:AnyObject?, error: NSError?) {
        
        if json == nil {
            return
        }
        
        EntryListParser().parse(json!)
    }
    
    class Builder: NSObject {
    
        // リクエスト先のURL
        private let mRequestUrl: String
        
        // APIのパース結果を受け取った時のコールバック
        private var mOnReceiveEntryList: ([Entry] -> Void)?
        
        // エラー時のコールバック
        private var mOnRequestFaild: (() -> Void)?
        
        init(url: String) {
            mRequestUrl = url
        }
        
        func setOnReceiveEntryList(onReceiveEntryList: [Entry] -> Void) -> Builder {
            mOnReceiveEntryList = onReceiveEntryList
            return self
        }
        
        func setOnRequestFaild(onRequestFailed: () -> Void) -> Builder {
            mOnRequestFaild = onRequestFailed
            return self
        }
        
        func build() -> EntryListRequest {
            return EntryListRequest(builder: self)
        }
    }
}
