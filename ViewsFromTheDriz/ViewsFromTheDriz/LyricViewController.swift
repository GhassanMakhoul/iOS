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
    let feud = FeudBrain()
    @IBOutlet weak var Drizzy: UIButton!
    @IBOutlet weak var Meek: UIButton!
    
    private var lyrics = "" {
        didSet{
            lyricView?.text = "'\(lyrics)'"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lyrics = feud.getLyric()
    }
}
