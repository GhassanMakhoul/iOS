//
//  MentionsTableViewCell.swift
//  SmashTag
//
//  Created by Ghassan Makhoul on 8/7/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit

class MentionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var title: UILabel!
    var mentions: String? {
        didSet {
            updateUI()
        }
    }
    
    var header = ""
    
    func updateUI() {
        if let content = mentions {
            if body != nil {
                body.text = mentions
            }
            if title != nil {
                self.title.text = self.header
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
