//
//  LyricViewController.swift
//  ViewsFromTheDriz
//
//  Created by Ghassan Makhoul on 8/2/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit

class LyricViewController: UIViewController {

    @IBOutlet weak var lyricView: UILabel! {
        didSet {
            lyricView.text = "'\(lyrics)'"
        }
    }
    
    var response: String?
    let feud = FeudBrain()
    var right: Bool? {
        didSet{
            updateUI()
        }
    }

 
    @IBAction func rapper(sender: UIButton) {
        response = sender.currentTitle
        right = feud.checkAnswer(response!, lyric: lyricView?.text ?? "" )
        
    }

    
    private var lyrics = "" {
        didSet{
            lyricView?.text = "'\(lyrics)'"
        }
    }
    func updateUI() {
        if let correct = right {
            if correct {
                lyricView.text = "correct!"
                lyrics = feud.getLyric()
                right = false
            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lyrics = feud.getLyric()
    }
}
