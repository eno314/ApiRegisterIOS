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
private let TEXT_FIELD_PLACEHOLDER_TITLE = "表示名"
private let TEXT_FIELD_PLACEHOLDER_URL = "URL"
private let TEXT_FIELD_TAG_TITLE = 0
private let TEXT_FIELD_TAG_URL = 1

class AddApiDialogBuilder: NSObject {
    
    private let mAlertController: UIAlertController
    
    private var mOnValidInput: ((String, String) -> Void)?
    private var mOnInValidInput:(() -> Void)?
    
    override init() {
        mAlertController = UIAlertController(
            title: DIALOG_TITLE,
            message: DIALOG_MESSAGE,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        mOnValidInput = nil
        mOnInValidInput = nil
    }
    
    // 有効な文字が帰ってきたときのコールバックのセッター
    func setOnValidInput(handler: (String, String) -> Void) {
        mOnValidInput = handler
    }
    
    // 無効なインプットだった場合のコールバックのセッター
    func setOnInvalidInput(handler: () -> Void) {
        mOnInValidInput = handler
    }
    
    func build() -> UIAlertController {
        // タイトル入力枠
        mAlertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.tag = TEXT_FIELD_TAG_TITLE
            text.placeholder = TEXT_FIELD_PLACEHOLDER_TITLE
        })
        
        // URL入力枠
        mAlertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.tag = TEXT_FIELD_TAG_URL
            text.placeholder = TEXT_FIELD_PLACEHOLDER_URL
        })
        
        mAlertController.addAction(UIAlertAction(
            title: DIALOG_BUTTON_CANCEL,
            style: UIAlertActionStyle.Cancel,
            handler: nil))
        
        mAlertController.addAction(UIAlertAction(
            title: DIALOG_BUTTON_OK,
            style: UIAlertActionStyle.Default,
            handler: didClickAlertOkButton
        ))
        
        return mAlertController;
    }
    
    // OKボタンをおした時の処理
    private func didClickAlertOkButton(action: UIAlertAction!) {
            
        var title = ""
        var url = ""
        
        let textFields:Array<UITextField>? =  mAlertController.textFields as Array<UITextField>?
        
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
    
    private func callOnValidInput(title: String, url: String) {
        if mOnValidInput != nil {
            mOnValidInput!(title, url);
        }
    }
    
    private func callOnInValidInput() {
        if mOnInValidInput != nil {
            mOnInValidInput!()
        }
    }
}
