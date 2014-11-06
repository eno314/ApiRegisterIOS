//
//  WebViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/05.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var forwardButton: UIBarButtonItem!
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    private let mRootUrl: String
    
    init(url: String) {
        mRootUrl = url
        
        super.init(nibName: "WebViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        
        let requestUrl = NSURL(string: mRootUrl)
        self.webView.loadRequest(NSURLRequest(URL:requestUrl!))
        self.webView.scalesPageToFit = true
        
        self.backButton.enabled = false
        self.forwardButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // webviewのロード開始
    func webViewDidStartLoad(webView: UIWebView) {
        self.indicator.hidden = false
        self.indicator.startAnimating()
        
        if self.webView.canGoBack {
            self.backButton.enabled = true
        } else {
            self.backButton.enabled = false
        }
        
        if self.webView.canGoForward {
            self.forwardButton.enabled = true
        } else {
            self.forwardButton.enabled = false
        }
    }
    
    // webviewのロード終了
    func webViewDidFinishLoad(webView: UIWebView) {
        self.indicator.hidden = true
        self.indicator.stopAnimating()
    }
    
    // 戻るボタン押した時
    @IBAction func clickBackButton(sender: AnyObject) {
        self.webView.goBack()
    }
    
    // 進むボタンおした時
    @IBAction func clickForwardButton(sender: AnyObject) {
        self.webView.goForward()
    }
    
    @IBAction func clickReloadButton(sender: AnyObject) {
        self.webView.reload()
    }
}
