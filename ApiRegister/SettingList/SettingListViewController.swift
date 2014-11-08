//
//  SettingListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/08.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

private let TITLE = "設定一覧"

class SettingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.title = TITLE
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
        let cell: UITableViewCell =
        UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            
        cell.textLabel.text = "あああ"
            
        return cell
    }
    
    // セルタップ時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    // 追加ボタンをクリックした時の処理
    @IBAction func pressAddButton(sender: AnyObject) {
        presentViewController(AddApiViewController(), animated: true, completion: nil);
    }
}
