//
//  AddApiViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/08.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

private var STRAGE_TYPE_SETTING = 0
private var STRAGE_TYPE_API = 1

class AddApiViewController: UIViewController {
    
    @IBOutlet var titleText: UITextField!
    @IBOutlet var urlText: UITextField!
    @IBOutlet var warningLabel: UILabel!
    
    private var mInitTitle: String?
    private var mInitUrl: String?
    private var mStrageType: Int
    private var mOnClickButton: (() -> Void)?
    
    private init(builder: AddApiViewController.SettingBuilder) {
        mStrageType = STRAGE_TYPE_SETTING
        
        if builder.mSetting != nil {
            mInitTitle = builder.mSetting!.title
            mInitUrl = builder.mSetting!.url
        }
        
        if builder.mOnClickButton != nil {
            mOnClickButton = builder.mOnClickButton
        }
        
        super.init(nibName: "AddApiViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mInitTitle != nil {
            self.titleText.text = mInitTitle
        }
        
        if mInitUrl != nil {
            self.urlText.text = mInitUrl
        }
        
        titleText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pressButton(sender: AnyObject) {
        if self.titleText.text == nil || self.titleText.text == "" {
            self.warningLabel.text = "タイトル未入力"
            return
        }
        
        if self.urlText.text == nil || self.urlText.text == "" {
            self.warningLabel.text = "URL未入力"
            return
        }
        
        
        
        callOnClickButton()
    }
    
    @IBAction func pressCancelButton(sender: AnyObject) {
        callOnClickButton()
    }
    
    private func callOnClickButton() {
        if mOnClickButton != nil {
            mOnClickButton!()
        }
    }
    
    class SettingBuilder: NSObject {
        private var mSetting: Setting?
        private var mOnClickButton: (() -> Void)?
        
        func setOnClickButton(onClickButton: () -> Void) -> SettingBuilder {
            mOnClickButton = onClickButton
            return self
        }
        
        func setSetting(setting: Setting) -> SettingBuilder {
            mSetting = setting
            return self
        }
        
        func build() -> AddApiViewController {
            return AddApiViewController(builder: self)
        }
    }
}
