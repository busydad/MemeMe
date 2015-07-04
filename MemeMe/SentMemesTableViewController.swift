//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Per Dalsgaard on 25/06/15.
//  Copyright (c) 2015 Per Dalsgaard. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
   
    var memes: [Meme]!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = Meme.getMemes()
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue" {
            let memeDetailViewController = segue.destinationViewController as! MemeDetailViewController
            let optinalIndexPath = tableView.indexPathForCell(sender as! SentMemeTableViewCell)
            if let indexPath = optinalIndexPath {
                memeDetailViewController.meme = memes[indexPath.row]
            }
        }
    }
}

extension SentMemesTableViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Meme.getMemes().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! SentMemeTableViewCell
        
        let meme = memes[indexPath.row];
        cell.memeImageView.image = meme.image
        cell.memeTextLabel.text = "\(meme.top)...\(meme.bottom)"
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!,
            NSStrokeWidthAttributeName : -2.0, // a negative value. If this value is positive I will only see the stroke and not the fill.
        ]
        
        cell.topLabel.attributedText = NSAttributedString(string: meme.top, attributes: memeTextAttributes)
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottom, attributes: memeTextAttributes)
        
        return cell
    }
}