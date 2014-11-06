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
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    func setNoImage() {
        
    }
    
    func setImageUrl(imageUrl: String) {
        startLoading()
        Alamofire.request(.GET, imageUrl).response { (request, response, data, error) -> Void in
            if error == nil {
                self.stopLoading()
                self.entryImageView.image = UIImage(data: data as NSData)
            }
        }
    }
    
    private func startLoading() {
        self.indicator.startAnimating()
        self.indicator.hidden = false
    }
    
    private func stopLoading() {
        self.indicator.stopAnimating()
        self.indicator.hidden = true
    }
}
