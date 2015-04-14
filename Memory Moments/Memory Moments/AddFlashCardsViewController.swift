//
//  AddFlashCardsViewController.swift
//  Memory Moments
//
//  Created by Jadav, Jigar on 4/13/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit

class AddFlashCardsViewController: UIViewController , UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //ID, time, Type, Discribtion, title
    var event = [(Int(), NSDate(), String(), String(), String())];
    var currentCards = [Flashcards]()
    
    @IBOutlet weak var InformationBox: UITextView!
    var picker = UIImagePickerController()
    @IBOutlet var imagePerson: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet var Info: UITextView!
    @IBOutlet var loading: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        InformationBox.layer.borderWidth = 1;
        InformationBox.layer.borderColor = UIColor.grayColor().CGColor
        InformationBox.delegate = self;
        loading.hidden = true;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func keyBoardDown(sender: AnyObject) {
        InformationBox.resignFirstResponder()
    }

    @IBAction func photoFromLibrary(sender: AnyObject) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    //delagates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePerson.contentMode = .ScaleAspectFit
        imagePerson.image = chosenImage
        button.titleLabel?.text = ""
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addFlash(sender: AnyObject) {
        loading.hidden = false;
        loading.startAnimating()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
