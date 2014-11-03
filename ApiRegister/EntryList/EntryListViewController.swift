//
//  EntryListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit
import Alamofire

private let CELL_ID_DEFAULT = "CELL_DEFAULT"
private let CELL_ID_IMAGE = "CELL_IMAGE"
private let IMAGE_CELL_HEIGHT: CGFloat = 100
private let DEFAULT_CELL_HEIGHT: CGFloat = 90
private let DEFAUTL_CELL_TEXT_LINE = 3

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
        
        mTableView.registerNib(UINib(nibName: "EntryListTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_ID_IMAGE)
        
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
        let entry: Entry = mEntryList[indexPath.row]
        
        if entry.image == nil {
            return createTableViewCell(entry)
        } else {
            return createTableViewCellWithImage(entry)
        }
    }
    
    // セルタップ時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(mEntryList[indexPath.row].url)
    }
    
    // セルの高さ
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if hasImage(indexPath.row) {
            return IMAGE_CELL_HEIGHT
        }
        
        return DEFAULT_CELL_HEIGHT
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
    
    // 画像なしのセル生成
    private func createTableViewCell(entry: Entry) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CELL_ID_DEFAULT)
        cell.textLabel.text = entry.title
        cell.textLabel.numberOfLines = DEFAUTL_CELL_TEXT_LINE
        return cell
    }
    
    // 画像ありのセル生成
    private func createTableViewCellWithImage(entry: Entry) -> UITableViewCell {
        var cell: EntryListTableViewCell = mTableView.dequeueReusableCellWithIdentifier(CELL_ID_IMAGE) as EntryListTableViewCell
        cell.setTitle(entry.title!)
        cell.setImageUrl(entry.image!)
        
        return cell
    }
    
    private func hasImage(index: Int) -> Bool {
        if mEntryList[index].image == nil {
            return false
        }
        
        return true
    }
}
