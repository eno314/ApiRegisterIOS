//
//  EntryListTableViewCell.swift
//  ApiRegister
//
//  Created by hiroto kitamur on 2014/11/03.
//  Copyright (c) 2014年 eno. All rights reserved.
//

import UIKit

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
    
    func setImageUrl(imageUrlString: String) {
        // TODO 非同期化
        let imageURL: NSURL? = NSURL(string: imageUrlString)
        
        if imageURL != nil {
            var error: NSError?
            var imageData: NSData? = NSData(contentsOfURL: imageURL!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
            if error == nil {
                entryImageView.contentMode = UIViewContentMode.ScaleAspectFit
                entryImageView.image = UIImage(data: imageData!)
            } else {
                println(error)
            }
        }
    }
}
