//
//  ApiListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

private let TITLE = "登録一覧"

class ApiListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.delegate = self
        mTableView.dataSource = self
        
        self.title = TITLE
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApiListStrage.get().count;
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell: UITableViewCell =
            UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            
            cell.textLabel.text = ApiListStrage.get()[indexPath.row].title
            
            return cell
    }
    
    // セルタップ時
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let apiInfo: ApiInfo = ApiListStrage.get()[indexPath.row]
        let entryListVC = EntryListViewController(apiTitle: apiInfo.title, apiUrl: apiInfo.url)
        self.navigationController?.pushViewController(entryListVC, animated: true)
    }
    
    // APIをリストに追加するためのダイアログ生成
    private func buildAddApiDialog() -> UIAlertController {
        var builder: AddApiDialogBuilder = AddApiDialogBuilder()
        builder.setOnInvalidInput(onFailedReceiveApiInfo)
        builder.setOnValidInput(onReceiveApiInfo)
        return builder.build()
    }
    
    // API追加ダイアログからAPI情報を受け取った時のコールバック
    private func onReceiveApiInfo(title: String, url: String) {
        ApiListStrage.add(url, title: title)
        mTableView.reloadData()
    }
    
    // API追加ダイアログからAPI情報を受取るのが失敗した時のコールバック
    private func onFailedReceiveApiInfo() {
        println("入力がたりねーよ")
    }
    
    // 追加ボタンをクリックした時の処理
    @IBAction func pressAddButton(sender: AnyObject) {
        presentViewController(buildAddApiDialog(), animated: true, completion: nil);
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
