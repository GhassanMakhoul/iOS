//
//  TweetContentTableViewCell.swift
//  SmashTag
//
//  Created by Ghassan Makhoul on 8/6/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit

class MediaContentTableViewCell: UITableViewCell {
    var media: NSURL? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var images: UIImageView!
    func updateUI() {
        if images != nil {
            if let mData = media {
                if let content = NSData(contentsOfURL:  mData) {
                    let img = UIImage(data: content)
                    images.image = img
                }
                
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
