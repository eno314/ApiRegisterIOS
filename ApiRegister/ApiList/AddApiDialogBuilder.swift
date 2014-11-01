//
//  AddApiDialogBuilder.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

private let DIALOG_BUTTON_CANCEL = "キャンセル"
private let DIALOG_BUTTON_OK = "完了"
private let DIALOG_TITLE = "APIの追加"
private let DIALOG_MESSAGE = "追加するAPI情報を入力してください"
private let TEXT_FIELD_PLACEHOLDER_TITLE = "タイトル"
private let TEXT_FIELD_PLACEHOLDER_URL = "URL"
private let TEXT_FIELD_TAG_TITLE = 0
private let TEXT_FIELD_TAG_URL = 1

class AddApiDialogBuilder: NSObject {
    
    func build() -> UIAlertController {
        let alertController:UIAlertController = UIAlertController(
            title: DIALOG_TITLE,
            message: DIALOG_MESSAGE,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        // タイトル入力枠
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.tag = TEXT_FIELD_TAG_TITLE
            text.placeholder = TEXT_FIELD_PLACEHOLDER_TITLE
        })
        
        // URL入力枠
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.tag = TEXT_FIELD_TAG_URL
            text.placeholder = TEXT_FIELD_PLACEHOLDER_URL
        })
        
        alertController.addAction(createAlertActionCancel())
        alertController.addAction(createAlertActionOK(alertController))
        
        return alertController;
    }
    
    // キャンセルボタンのアクション追加
    func createAlertActionCancel() -> UIAlertAction {
        return UIAlertAction(title: DIALOG_BUTTON_CANCEL, style: UIAlertActionStyle.Cancel, nil)
    }
    
    // OKボタンのアクション追加
    func createAlertActionOK(alert: UIAlertController) -> UIAlertAction {
        return UIAlertAction(
            title: DIALOG_BUTTON_OK,
            style: UIAlertActionStyle.Default,
            handler:{(action:UIAlertAction!) -> Void in
                self.didClickAlertOkButton(alert)
        })
    }
    
    // OKボタンをおした時の処理
    func didClickAlertOkButton(alert: UIAlertController) {
        var title = ""
        var url = ""
        
        let textFields:Array<UITextField>? =  alert.textFields as Array<UITextField>?
        if textFields != nil {
            for textField:UITextField in textFields! {
                if textField.tag == TEXT_FIELD_TAG_TITLE {
                    title = textField.text
                } else if textField.tag == TEXT_FIELD_TAG_URL {
                    url = textField.text
                }
            }
        }
        
        if title.isEmpty {
            return
        }
        
        if url.isEmpty{
            return
        }
        
        // ApiListStrage.add(url, title: title)
        
        // self.tableView.reloadData()
    }
}
