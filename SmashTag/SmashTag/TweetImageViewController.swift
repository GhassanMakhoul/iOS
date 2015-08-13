//
//  TweetImageViewController.swift
//  SmashTag
//
//  Created by Ghassan Makhoul on 8/9/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit

class TweetImageViewController: UIViewController, UIScrollViewDelegate {
    var img : UIImage? {
        get { return imgView.image}
        set{
            imgView.image = newValue
            imgView.sizeToFit()
            scrollView?.contentSize = imgView.frame.size
            
        }
    }

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imgView.frame.size
            scrollView.delegate = self
            scrollView.maximumZoomScale = 2.0
            scrollView.minimumZoomScale = 0.05
        }
    }
    private var imgView = UIImageView()
    func updateUI() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imgView)
        scrollView.contentSize = imgView.frame.size
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imgView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
