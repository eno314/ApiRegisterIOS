//
//  Entry.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class Entry: NSObject {
    
    // 記事のタイトル
    var title: String?
    
    // リンク先のURL
    var url: String?
    
    // 記事の画像（ない場合あり）
    var image: String?
    
    // 有効なデータかどうか判断用のメソッド
    func isValid() -> Bool {
        
        if title == nil {
            return false
        }
        
        if url == nil {
            return false
        }
        
        return true
    }
}
