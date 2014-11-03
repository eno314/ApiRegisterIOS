//
//  EntryListTableViewCell.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/03.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit
import Alamofire

class EntryListTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var entryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setNoImage() {
        
    }
    
    func setImageUrl(imageUrl: String) {
        Alamofire.request(.GET, imageUrl).response { (request, response, data, error) -> Void in
            if error == nil {
                self.entryImageView.image = UIImage(data: data as NSData)
            }
        }
    }
}
