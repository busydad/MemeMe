//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Per Dalsgaard on 22/06/15.
//  Copyright (c) 2015 Per Dalsgaard. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var meme: Meme?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        if let currentMeme = meme {
            topTextField.text = currentMeme.top
            bottomTextField.text = currentMeme.bottom
            imageView.image = currentMeme.image

        } else {
            topTextField.text = "TOP"
            bottomTextField.text = "BOTTOM"
            actionButton.enabled = false
        }
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -4.0, // a negative value. If this value is positive I will only see the stroke and not the fill.
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
        topTextField.autocapitalizationType = .AllCharacters
        bottomTextField.autocapitalizationType = .AllCharacters
        
        topTextField.tintColor = UIColor.whiteColor()
        bottomTextField.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // Hide status bar
        return true
    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        showToolbars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        showToolbars(false)
        
        return memedImage
    }
    
    func showToolbars (status: Bool)
    {
        topToolbar.hidden = status
        bottomToolbar.hidden = status
    }
    
    func save(generatedMemeImage: UIImage) {
        //Create the meme
        var meme = Meme(top: topTextField.text, bottom: bottomTextField.text, image: imageView.image!, memedImage: generatedMemeImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    // MARK: - Move view according to keyboard height
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            actionButton.enabled = true
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - IBAction
    
    @IBAction func shareMeme(sender: AnyObject) {
        // Present the Activity View Controller
        let image = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = { (type: String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) in
            if completed {
                self.save(image)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension MemeEditorViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text == "" {
            if textField == topTextField {
                textField.text = "TOP"
            } else {
                textField.text = "BOTTOM"
                
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var oldText = textField.text as NSString
        var newText = oldText.stringByReplacingCharactersInRange(range, withString: string)
        newText = newText.uppercaseString;
        textField.text = newText
        return false
    }
}
