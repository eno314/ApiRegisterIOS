//
//  ApiListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/09.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class ApiListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    private var mSettingApiUrl: String?
    private var mApiList: ApiList?
    
    init(title: String) {
        super.init(nibName: "ApiListViewController", bundle: nil)
        self.title = title
    }
    
    init(title: String, url: String) {
        mSettingApiUrl = url
        super.init(nibName: "ApiListViewController", bundle: nil)
        self.title = title
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if mSettingApiUrl == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "＋", style: .Plain, target: self, action: "onClickAddButton:")
        } else {
            request()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mSettingApiUrl == nil {
            return ApiListStrage.get().count;
        }
        
        if mApiList == nil {
            return 0
        }
        
        return mApiList!.list!.count
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell =
        UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        if mSettingApiUrl == nil {
            cell.textLabel.text = ApiListStrage.get()[indexPath.row].title
        } else {
            cell.textLabel.text = mApiList!.list![indexPath.row].title
        }
        
        return cell
    }
    
    // セルタップ時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var apiInfo: ApiInfo
        if mSettingApiUrl == nil {
            apiInfo = ApiListStrage.get()[indexPath.row]
        } else {
            apiInfo = mApiList!.list![indexPath.row]
        }
        
        let entryListVC = EntryListViewController(apiTitle: apiInfo.title!, apiUrl: apiInfo.url!)
        self.navigationController?.pushViewController(entryListVC, animated: true)
    }
    
    func onClickAddButton(sender: UIButton) {
        println("AAAA")
    }
    
    // APIリクエスト
    private func request() {
        // startLoading()
        println("start request")
        let builder: ApiListRequest.Builder = ApiListRequest.Builder(url: mSettingApiUrl!)
        builder.setOnReceiveApiList(onReceiveApiList)
        builder.setOnRequestFaild(onRequestFaild)
        builder.build().execute()
    }
    
    // APIのパース結果を受け取った時のコールバック実装
    private func onReceiveApiList(apiList: ApiList) {
        // stopLoading()
        mApiList = apiList
        self.tableView.reloadData()
    }
    
    // APIリクエストに失敗した時のコールバック実装
    private func onRequestFaild() {
        // stopLoading()
        println("request failed...")
    }

}
