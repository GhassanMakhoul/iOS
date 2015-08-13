//
//  TweetContentTableViewController.swift
//  SmashTag
//
//  Created by Ghassan Makhoul on 8/6/15.
//  Copyright (c) 2015 Ghassan Makhoul. All rights reserved.
//

import UIKit
import Foundation

public struct Mentions: Printable {
    var Title: String
    var Mentions: [Content]
    
    init?(media: [MediaItem]) {
        if media.isEmpty {
            return nil
        }
        Mentions  = media.map{ (media) -> Content in
            Content.Image(data: media.url)
        }
     
            Title = "Images"
        
    }
    init?(mentions: [Tweet.IndexedKeyword], title: String) {
        if mentions.isEmpty {return nil}
        Mentions = mentions.map{ indexed -> Content in
            Content.KeyWord(indexed.keyword)
        }

            Title = title
        
    }
    
    func count() -> Int{
        return Mentions.count
    }
    
     public var description: String {
        get {
            return Title
        }
    }
    
 
}

public enum Content {
    case KeyWord(String)
    case Image(data: NSURL)


}

class TweetContentTableViewController: UITableViewController {
    var content: Tweet? {
        didSet {

            if let tweet = content {
                println("\(tweet.mediaMentions.count)")
                if  !tweet.media.isEmpty {
                    mentions.append(Mentions(media: tweet.media)!)
                }
                if !tweet.hashtags.isEmpty {
                    mentions.append(Mentions(mentions: tweet.hashtags, title: "Hashtag")!)
                }
                if !tweet.mediaMentions.isEmpty {
                    mentions.append(Mentions(mentions: tweet.mediaMentions, title: "Media Mentions")!)
                }
                if !tweet.userMentions.isEmpty{
                    mentions.append(Mentions(mentions: tweet.userMentions, title: "Users Mentioned")!)
                }

            }
        }
    }
    
    func getContent(content: Content) ->AnyObject {
        switch content {
        case .KeyWord(let key): return key
        case .Image(let imgURL): return imgURL
        }
    }
    func getlength(content: [Mentions]) -> Int {
//        switch content {
//        case .Media(let media): return media.count
//        case .Hashtag(let hashtag): return hashtag.count
//        case .Mentions(let mentions): return mentions.count
//        case .Users(let tweeter): return tweeter.counti
//        }
        
        return 0
    }

    typealias PropertyList = AnyClass
    var mentions = [Mentions]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between pres8entations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    //MARK: - Handling Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if  let navCon =  destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let clickedMedia = sender as? MediaContentTableViewCell {
            if let ivc = destination as? TweetImageViewController {
                ivc.img = clickedMedia.images.image
            }
        } else if let clicked = sender as? MentionsTableViewCell {
            if clicked.mentions != nil {
                let urlString = clicked.mentions!
                    if let url = NSURL(string: urlString) {
                            UIApplication.sharedApplication().openURL(url)
                    }
                } else if let stvc = destination as? SmashTabViewController {
                if let svc = stvc.presentedViewController as? SmashTableViewController {
                            svc.newSearch = clicked.mentions
                        }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return mentions.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return mentions[section].Mentions.count
    }
    
    func getIdentifier(indexPath: NSIndexPath) -> String {
        if !mentions.isEmpty {
            let idFind = mentions[indexPath.section].Title
                switch idFind {
                    case "Images": return "Images"
                    case "HashTag", "User Mentions", "Media Mentions": return "Mentions"
                default: return ""
                
                    }
            
        }
        return ""
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = getIdentifier( indexPath)
        let returnCell: UITableViewCell
        if identifier == "Images" {
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MediaContentTableViewCell
            cell.media = getContent(mentions[indexPath.section].Mentions[indexPath.row]) as? NSURL
            returnCell = cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Mentions", forIndexPath: indexPath) as! MentionsTableViewCell
            cell.header = mentions[indexPath.section].Title
            cell.mentions = getContent(mentions[indexPath.section].Mentions[indexPath.row]) as? String
            returnCell = cell
        }
        
        // Configure the cell...

        return returnCell
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
