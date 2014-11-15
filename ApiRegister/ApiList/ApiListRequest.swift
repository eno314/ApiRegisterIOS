//
//  ApiListRequest.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/11.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit
import Alamofire

class ApiListRequest: NSObject {
    // リクエスト先のURL
    private let mRequestUrl: String
    
    // APIのパース結果を受け取った時のコールバック
    private let mOnReceiveApiList: (ApiList -> Void)?
    
    // エラー時のコールバック
    private let mOnRequestFaild: (() -> Void)?
    
    // Builder専用のコンストラクタ
    private init(builder: ApiListRequest.Builder) {
        mRequestUrl = builder.mRequestUrl
        mOnReceiveApiList = builder.mOnReceiveApiList
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
        
        let apiList: ApiList? = ApiListParser().parse(json!)
        
        if apiList == nil {
            println("failed parse")
            callOnRequestFaild()
        } else {
            callOnReceiveApiList(apiList!)
        }
    }
    
    private func callOnRequestFaild() {
        if mOnRequestFaild != nil {
            mOnRequestFaild!()
        }
    }
    
    private func callOnReceiveApiList(apiList: ApiList) {
        if mOnReceiveApiList != nil {
            mOnReceiveApiList!(apiList)
        }
    }
    
    class Builder: NSObject {
        
        // リクエスト先のURL
        private let mRequestUrl: String
        
        // APIのパース結果を受け取った時のコールバック
        private var mOnReceiveApiList: (ApiList -> Void)?
        
        // エラー時のコールバック
        private var mOnRequestFaild: (() -> Void)?
        
        init(url: String) {
            mRequestUrl = url
        }
        
        func setOnReceiveApiList(onReceiveApiList: ApiList -> Void) -> Builder {
            mOnReceiveApiList = onReceiveApiList
            return self
        }
        
        func setOnRequestFaild(onRequestFailed: () -> Void) -> Builder {
            mOnRequestFaild = onRequestFailed
            return self
        }
        
        func build() -> ApiListRequest {
            return ApiListRequest(builder: self)
        }
    }
}
