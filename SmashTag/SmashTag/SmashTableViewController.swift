//
//  SmashTableViewController.swift
//  SmashTag
//
//  Created by Ghassan Makhoul on 8/4/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit

public struct DefaultKeys {
    static let History = "SmashTableViewController.History"
}

class SmashTableViewController: UITableViewController, UITextFieldDelegate  {
    var tweets = [[Tweet]]()
    var history = [String]()
    @IBAction func goBack(segue: UIStoryboardSegue) {
        lastSuccessfulRequest = nil
        refresh()
    }
    @IBAction func refresh(sender: UIRefreshControl?) {
        if let search = searchText {
            if let request = nextRequest {
                request.fetchTweets { (newTweets) -> Void in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        if newTweets.count > 0 {
//                            self.lastSuccessfulRequest = request
                            self.tweets.insert(newTweets, atIndex: 0)
                            self.tableView.reloadData()
                            sender?.endRefreshing()
                        }
                    }
                }
            }
            else {
                sender?.endRefreshing()
            }
        }
        else {
            sender?.endRefreshing()
        }
    }
    func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl)
    }
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            lastSuccessfulRequest = nil
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        return true
    }
    var newSearch: String?
    var searchText: String? = "#Yeezy" {
        didSet {
            searchText = searchTextField?.text
            tweets.removeAll()
            tableView.reloadData()
            refreshControl?.endRefreshing()
            if let item = searchText {
                addItemToHistory(item)
            }
            refresh()
            
        }
    }
    func addItemToHistory(item: String) {
        history.append(item)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.registerDefaults([DefaultKeys.History : history])
        
    }
    var lastSuccessfulRequest: TwitterRequest?
    var nextRequest: TwitterRequest? {
        if lastSuccessfulRequest == nil {
            if searchText != nil {
                return TwitterRequest(search: self.searchText!, count: 100)
            } else {
                return nil
            }
        }
        else {
            return lastSuccessfulRequest!.requestForNewer
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let tvc = destination as? TweetContentTableViewController {
            if let clickedCell = sender as? SmashTableViewCell {
                if let tweet = clickedCell.tweet {
                    var index = tvc.mentions.startIndex
                    tvc.content = tweet
                    
                }
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let seguedSearch = newSearch {
            searchTextField.text = seguedSearch
            searchText = seguedSearch
            newSearch = nil
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        refresh()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return tweets[section].count
    }
    
    private struct Storyboard {
        static let Identifier = "Tweet"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.Identifier, forIndexPath: indexPath) as! SmashTableViewCell
        let tweet = tweets[indexPath.section][indexPath.row]
        cell.tweet = tweet
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
