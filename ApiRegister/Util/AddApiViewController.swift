//
//  AddApiViewController.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/08.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

class AddApiViewController: UIViewController {
    
    override init() {
        super.init(nibName: "AddApiViewController", bundle: nil)
    }
    
    init(setting: Setting) {
        super.init(nibName: "AddApiViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
