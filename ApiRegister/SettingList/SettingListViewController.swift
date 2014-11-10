//
//  SettingListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/08.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

private let TITLE = "設定一覧"
private let TITLE_HANDMAKE = "手入力"
private let TITLE_SETTING = "設定API"
private let SECTION_COUNT = 2
private let SECTION_HANDMAKE = 0

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
        if section == SECTION_HANDMAKE {
            return 1
        } else {
            return SettingListStrage.get().count
        }
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell =
        UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        if indexPath.section == SECTION_HANDMAKE {
            cell.textLabel.text = TITLE_HANDMAKE
        } else {
            cell.textLabel.text = SettingListStrage.get()[indexPath.row].title
        }
        
        return cell
    }
    
    // セルタップ時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == SECTION_HANDMAKE {
            self.navigationController?.pushViewController(ApiListViewController(), animated: true)
        } else {
            let setting: Setting = SettingListStrage.get()[indexPath.row]
            self.navigationController?.pushViewController(ApiListViewController(title: setting.title, url: setting.url), animated: true)
        }
    }
    
    // ヘッダのタイトル
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == SECTION_HANDMAKE {
            return TITLE_HANDMAKE
        } else {
            return TITLE_SETTING
        }
    }
    
    // セクションの数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SECTION_COUNT
    }
    
    // 追加ボタンをクリックした時の処理
    @IBAction func pressAddButton(sender: AnyObject) {
        presentViewController(buildAddApiViewController(), animated: true, completion: nil);
    }
    
    private func buildAddApiViewController() -> AddApiViewController {
        return AddApiViewController.SettingBuilder().setOnClickButton(onClickButton).build()
    }
    
    private func onClickButton() {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}
