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
    private let mOnReceiveEntryList: (Array<Entry> -> Void)?
    
    // エラー時のコールバック
    private let mOnRequestFaild: (() -> Void)?
    
    // Builder専用のコンストラクタ
    private init(builder: EntryListRequest.Builder) {
        mRequestUrl = builder.mRequestUrl
        mOnReceiveEntryList = builder.mOnReceiveEntryList
        mOnRequestFaild = builder.mOnRequestFaild
    }
    
    // リクエスト実行メソッド
    func execute() {
        Alamofire.request(.GET, mRequestUrl).responseJSON(onResponse)
    }
    
    // レスポンスを受け取った時のコールバック実装
    private func onResponse(request: NSURLRequest, response: NSHTTPURLResponse?, json:AnyObject?, error: NSError?) {
        
        if error != nil {
            println(error)
            callOnRequestFaild()
            return
        }
        
        if json == nil {
            println("reponse json is null")
            callOnRequestFaild()
            return
        }
        
        let entryList: Array<Entry>? = EntryListParser().parse(json!)
        
        if entryList == nil {
            println("failed parse")
            callOnRequestFaild()
        } else {
            callOnReceiveEntryList(entryList!)
        }
    }
    
    private func callOnRequestFaild() {
        if mOnRequestFaild != nil {
            mOnRequestFaild!()
        }
    }
    
    private func callOnReceiveEntryList(entryList: Array<Entry>) {
        if mOnReceiveEntryList != nil {
            mOnReceiveEntryList!(entryList)
        }
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
