//
//  DrizzyViewController.swift
//  
//
//  Created by Ghassan Makhoul on 7/30/15.
//
//

import UIKit

class DrizzyViewController: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate{
    struct Storyboard {
        static let ScoreVC = "Show Score"
    }
     @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var imageURL : NSURL? {
        didSet {
            image = nil
            retrieveImage()
        }
    }
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {return imageView.image}
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
            }
    }

    var drakeScore = 2
    var meekScore = 0
    private func retrieveImage() {
        if let url = imageURL {
            spinner?.startAnimating()
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                    let imgData = NSData(contentsOfURL: url)
                    dispatch_async(dispatch_get_main_queue()) {
                        if url == self.imageURL {
                            if imgData != nil {
                                self.image = UIImage(data: imgData!)
                            } else {
                                self.image = nil
                                
                            }
                        }
                        
                }

            }

        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!, traitCollection: UITraitCollection!) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
             switch identifier{
             case Storyboard.ScoreVC:
                if let svc = segue.destinationViewController as? ScoreViewController {
                    if let ppc = svc.presentationController {
                        ppc.delegate = self
                    }
                    svc.score = "Drake: \(drakeScore) - Meek: \(meekScore)"
                }
             default: break
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.frame.size


    }
    //IF image is not loaded, but image is nil
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            retrieveImage()
        }
    }
    
}
