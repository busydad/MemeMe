//
//  SentMemeTableViewCell.swift
//  MemeMe
//
//  Created by Per Dalsgaard on 29/06/15.
//  Copyright (c) 2015 Per Dalsgaard. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTextLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        memeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        memeImageView.clipsToBounds = true
        memeTextLabel.adjustsFontSizeToFitWidth = true
        memeTextLabel.minimumScaleFactor = 0.8 // Just an experiment. I would like to know how to configure that in code (as I do with most of my UI elements)
        topLabel.textAlignment = .Center
        bottomLabel.textAlignment = .Center
    }
}
