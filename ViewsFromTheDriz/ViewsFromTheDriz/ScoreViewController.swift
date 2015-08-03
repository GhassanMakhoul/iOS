//
//  ScoreViewController.swift
//  ViewsFromTheDriz
//
//  Created by Ghassan Makhoul on 7/31/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    var score = "0-0" {
        didSet {
            scoreView?.text = score
        }
    }
    
    
    @IBOutlet weak var scoreView: UITextView! {
        didSet{
            scoreView.text = score
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if scoreView != nil  && presentingViewController != nil{
                return scoreView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set{super.preferredContentSize = newValue}
    }
}
