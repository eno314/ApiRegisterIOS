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
    
    override init() {
        super.init(nibName: "ApiListViewController", bundle: nil)
    }
    
    init(url: String) {
        mSettingApiUrl = url
        super.init(nibName: "ApiListViewController", bundle: nil)
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
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApiListStrage.get().count;
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell =
        UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel.text = ApiListStrage.get()[indexPath.row].title
        
        return cell
    }
    
    // セルタップ時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let apiInfo: ApiInfo = ApiListStrage.get()[indexPath.row]
        let entryListVC = EntryListViewController(apiTitle: apiInfo.title!, apiUrl: apiInfo.url!)
        self.navigationController?.pushViewController(entryListVC, animated: true)
    }
    
    func onClickAddButton(sender: UIButton) {
        println("AAAA")
    }
}
