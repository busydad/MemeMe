//
//  SentMemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Per Dalsgaard on 30/06/15.
//  Copyright (c) 2015 Per Dalsgaard. All rights reserved.
//

import UIKit

class SentMemeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        memeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        memeImageView.backgroundColor = UIColor.blackColor()
        topLabel.textAlignment = .Center
        bottomLabel.textAlignment = .Center
    }
}
