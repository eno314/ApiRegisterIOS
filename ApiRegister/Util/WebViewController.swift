//
//  WebViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/05.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // webviewのロード開始
    func webViewDidStartLoad(webView: UIWebView) {
        self.indicator.hidden = false
        self.indicator.startAnimating()
    }
    
    // webviewのロード終了
    func webViewDidFinishLoad(webView: UIWebView) {
        self.indicator.hidden = true
        self.indicator.stopAnimating()
    }
}
