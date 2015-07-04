//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Per Dalsgaard on 25/06/15.
//  Copyright (c) 2015 Per Dalsgaard. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = Meme.getMemes()
        collectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue" {
            let memeDetailViewController = segue.destinationViewController as! MemeDetailViewController
            let optinalIndexPath = collectionView.indexPathForCell(sender as! SentMemeCollectionViewCell)
            if let indexPath = optinalIndexPath {
                memeDetailViewController.meme = memes[indexPath.row]
            }
        }
    }
}

extension SentMemesCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemeCollectionViewCell", forIndexPath: indexPath) as! SentMemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.image;
        cell.topLabel.text = meme.top
        cell.bottomLabel.text = meme.bottom
        
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
