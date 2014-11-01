//
//  ApiListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class ApiListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    // セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell: UITableViewCell =
            UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            
            cell.textLabel.text = "Hogehoge"
            return cell
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
        println("title : " + title)
        println("url : " + url)
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
