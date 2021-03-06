//
//  Meme.swift
//  MemeMe
//
//  Created by Per Dalsgaard on 28/06/15.
//  Copyright (c) 2015 Per Dalsgaard. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var top: String
    var bottom : String
    var image: UIImage
    var memedImage: UIImage
    
    init(top: String, bottom: String, image: UIImage, memedImage: UIImage) {
        self.top = top
        self.bottom = bottom
        self.image = image
        self.memedImage = memedImage
    }
    
    static func getMemes() -> [Meme] {
        return getMemeStorage().memes
    }
    
    static func getMemeStorage() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    
    static func removeAtIndex(index: Int) {
        Meme.getMemeStorage().memes.removeAtIndex(index)
    }
}
