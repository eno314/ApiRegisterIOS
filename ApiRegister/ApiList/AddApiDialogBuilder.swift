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
    
    let alertController: UIAlertController
    var onValidInput: ((String, String) -> Void)?
    var onInValidInput:(() -> Void)?
    
    override init() {
        self.alertController = UIAlertController(
            title: DIALOG_TITLE,
            message: DIALOG_MESSAGE,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        self.onValidInput = nil
        self.onInValidInput = nil
    }
    
    // 有効な文字が帰ってきたときのコールバックのセッター
    func setOnValidInput(handler: (String, String) -> Void) {
        self.onValidInput = handler
    }
    
    // 無効なインプットだった場合のコールバックのセッター
    func setOnInvalidInput(handler: () -> Void) {
        self.onInValidInput = handler
    }
    
    func build() -> UIAlertController {
        // タイトル入力枠
        self.alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.tag = TEXT_FIELD_TAG_TITLE
            text.placeholder = TEXT_FIELD_PLACEHOLDER_TITLE
        })
        
        // URL入力枠
        self.alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.tag = TEXT_FIELD_TAG_URL
            text.placeholder = TEXT_FIELD_PLACEHOLDER_URL
        })
        
        self.alertController.addAction(UIAlertAction(
            title: DIALOG_BUTTON_CANCEL,
            style: UIAlertActionStyle.Cancel,
            handler: nil))
        
        self.alertController.addAction(UIAlertAction(
            title: DIALOG_BUTTON_OK,
            style: UIAlertActionStyle.Default,
            handler: { (action: UIAlertAction!) -> Void in
                self.didClickAlertOkButton()
            }
        ))
        
        return self.alertController;
    }
    
    // OKボタンをおした時の処理
    func didClickAlertOkButton() {
            
        var title = ""
        var url = ""
        
        let textFields:Array<UITextField>? =  self.alertController.textFields as Array<UITextField>?
        
        if textFields == nil {
            callOnInValidInput()
            return
        }
        
        for textField:UITextField in textFields! {
            if textField.tag == TEXT_FIELD_TAG_TITLE {
                title = textField.text
            } else if textField.tag == TEXT_FIELD_TAG_URL {
                url = textField.text
            }
        }
        
        if title.isEmpty {
            callOnInValidInput()
            return
        }
        
        if url.isEmpty{
            callOnInValidInput()
            return
        }
        
        callOnValidInput(title, url: url)
    }
    
    func callOnValidInput(title: String, url: String) {
        if self.onValidInput != nil {
            self.onValidInput!(title, url);
        }
    }
    
    func callOnInValidInput() {
        if self.onInValidInput != nil {
            self.onInValidInput!()
        }
    }
}
