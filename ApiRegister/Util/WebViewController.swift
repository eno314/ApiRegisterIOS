//
//  WebViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/05.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
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
        
        let requestUrl = NSURL(string: mRootUrl)
        self.webView.loadRequest(NSURLRequest(URL:requestUrl!))
        self.webView.scalesPageToFit = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
