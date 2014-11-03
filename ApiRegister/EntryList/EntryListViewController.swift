//
//  EntryListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class EntryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mTableView: UITableView!
    
    private let mApiUrl: String
    
    private var mEntryList: Array<Entry>
    
    // APIリストの画面から遷移するためのコンストラクタ
    init(apiTitle: String, apiUrl: String) {
        // super.initの前に書かないとエラーになる。。。
        mApiUrl = apiUrl
        mEntryList = []
        
        super.init(nibName: "EntryListViewController", bundle: nil)
        self.title = apiTitle
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.delegate = self
        mTableView.dataSource = self
        
        request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mEntryList.count;
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(
            style: UITableViewCellStyle.Subtitle,
            reuseIdentifier: "Cell")
        cell.textLabel.text = mEntryList[indexPath.row].title
        return cell
    }
    
    // セルタップ時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(mEntryList[indexPath.row].url)
    }
    
    // APIリクエスト
    private func request() {
        let builder: EntryListRequest.Builder = EntryListRequest.Builder(url: mApiUrl)
        builder.setOnReceiveEntryList(onReceiveEntryList)
        builder.setOnRequestFaild(onRequestFaild)
        builder.build().execute()
    }
    
    // APIのパース結果を受け取った時のコールバック実装
    private func onReceiveEntryList(entryList: Array<Entry>) {
        mEntryList = entryList
        mTableView.reloadData()
    }
    
    // APIリクエストに失敗した時のコールバック実装
    private func onRequestFaild() {
        println("request failed...")
    }
}
