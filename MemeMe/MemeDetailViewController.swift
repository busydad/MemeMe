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
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet var deleteBarButton: UIBarButtonItem!
    
    var meme: Meme!
    var memeIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add bar buttons
        navigationItem.rightBarButtonItems = [editBarButton, deleteBarButton]
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = meme.memedImage
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMemeEditorSegue" {
            let memeEditorViewController = segue.destinationViewController as! MemeEditorViewController
            memeEditorViewController.meme = meme
        }
    }
    
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        Meme.removeAtIndex(memeIndex)
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
    }
}
