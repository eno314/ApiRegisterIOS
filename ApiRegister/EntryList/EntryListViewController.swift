//
//  EntryListViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/01.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit
import Alamofire

class EntryListViewController: UIViewController {
    
    let mApiUrl: String
    
    // APIリストの画面から遷移するためのコンストラクタ
    init(apiTitle: String, apiUrl: String) {
        // super.initの前に書かないとエラーになる。。。
        mApiUrl = apiUrl
        
        super.init(nibName: "EntryListViewController", bundle: nil)
        self.title = apiTitle
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Alamofire.request(.GET, mApiUrl).responseJSON(onResponse)
    }
    
    private func onResponse(request: NSURLRequest,
                            response: NSHTTPURLResponse?,
                            json:AnyObject?,
                            error: NSError?) {
        println(json)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
