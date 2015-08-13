//
//  SmashTableViewCell.swift
//  SmashTag
//
//  Created by Ghassan Makhoul on 8/5/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit

class SmashTableViewCell: UITableViewCell {
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var tweetTextField: UILabel!
    @IBOutlet weak var userName: UILabel!
    var attributedText: NSMutableAttributedString?
    var tweet: Tweet? {
        didSet{
            
            highlightTweet( tweet?.text, Keywords: tweet?.hashtags, color: UIColor.purpleColor())
            highlightTweet( tweet?.text, Keywords: tweet?.userMentions, color: UIColor.orangeColor())
            highlightTweet( tweet?.text, Keywords: tweet?.mediaMentions, color: UIColor.blueColor())
            updateUI()
        }
    }
    
    func highlightTweet(tweetText: String?, Keywords: [Tweet.IndexedKeyword]?, color: UIColor)  {
        if let textSoFar = attributedText {
            if let Keys = Keywords {
                for key in Keys {
                    textSoFar.addAttribute(NSForegroundColorAttributeName, value: color, range: key.nsrange)
                }
            attributedText = textSoFar
            }
        }
        else if let text = tweetText {
            var attributedTweet = NSMutableAttributedString(string: text)
            if let Keys = Keywords {
            for key in Keys {
                    attributedTweet.addAttribute(NSForegroundColorAttributeName, value: color, range: key.nsrange)
                }
                attributedText = attributedTweet
            }
        }
    }
    
    func updateUI() {
        userProfilePicture.image = nil
        tweetTextField.attributedText = nil
        userName.text = nil
        
        if let tweet = self.tweet {
            tweetTextField?.attributedText = attributedText! ?? NSMutableAttributedString(string: tweet.text)
            attributedText = nil
            userName?.text = tweet.user.name
            let img = NSData(contentsOfURL: tweet.user.profileImageURL!)
            userProfilePicture.image = img != nil ? UIImage(data: img!) : nil
        }
        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
