//
//  EntryListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class EntryListViewController: UIViewController {
    
    let mApiUrl: String
    
    // APIリストの画面から遷移するためのコンストラクタ
    init(apiTitle: String, apiUrl: String) {
        // super.initの前に書かないとエラーになる。。。
        mApiUrl = apiUrl
        
        super.init(nibName: "EntryListViewController", bundle: nil)
        self.title = apiTitle
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var builder: EntryListRequest.Builder = EntryListRequest.Builder(url: mApiUrl)
        builder.setOnReceiveEntryList(onReceiveEntryList)
        builder.setOnRequestFaild(onRequestFaild)
        builder.build().execute()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func onReceiveEntryList(entryList: Array<Entry>) {
        println(entryList)
    }
    
    private func onRequestFaild() {
        println("request failed...")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
