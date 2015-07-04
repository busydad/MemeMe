//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Per Dalsgaard on 30/06/15.
//  Copyright (c) 2015 Per Dalsgaard. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = meme.memedImage
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMemeEditorSegue" {
            let memeEditorViewController = segue.destinationViewController as! MemeEditorViewController
            memeEditorViewController.meme = meme
        }
    }
}
