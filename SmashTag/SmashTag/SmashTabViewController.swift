//
//  SmahTabViewController.swift
//  
//
//  Created by Ghassan Makhoul on 8/11/15.
//
//

import UIKit

class SmashTabViewController: UITabBarController {
    @IBAction func goBack(segue: UIStoryboardSegue) {
        if let svc = self.presentedViewController as? SmashTableViewController{
           svc.lastSuccessfulRequest = nil
            svc.refresh()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewControllerForUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject?) -> UIViewController? {
        let resultVC = self.selectedViewController?.viewControllerForUnwindSegueAction(action, fromViewController: fromViewController, withSender: sender)
        return resultVC
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
