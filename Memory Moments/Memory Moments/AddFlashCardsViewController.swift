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
    var secondFlashSending = false;
    
    @IBOutlet var name: UITextField!
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
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
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
        if imagePerson.image == nil {
            let alertController = UIAlertController(title: "Problem", message:
                "No image added\nPlease add image and try again", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return;
        }
        loading.hidden = false;
        loading.startAnimating()
        var pid: String = "";
        var path2: String!;
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent("PID.txt");
            path2 = dir.stringByAppendingPathComponent("fcid.txt");
            
            //reading to get the PID of person
            pid = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
            println(pid)
        }
        var c: UInt8 = UInt8();
        var imageData = UIImageJPEGRepresentation(imagePerson.image, 0.5)
        var img: NSData = imageData
        if imageData != nil{
            var request = NSMutableURLRequest(URL: NSURL(string:"http://aakatz3.asuscomm.com:8085/mobile/createflashcard.php")!)
            var session = NSURLSession.sharedSession()
            
            request.HTTPMethod = "POST"
            
            var boundary = NSString(format: "---------------------------14737809831466499882746641449")
            var contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
            //  println("Content Type \(contentType)")
            request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
            
            var body = NSMutableData.alloc()
            
            // Title
            body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"pid\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData("\(pid)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
            
            body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"name\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData("\(name.text)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
            
            body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"info\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData("\(Info.text)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
            
            body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"description\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData("\(Info.text)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
            
            // Image
            body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"picture\"; filename=\"img.jpg\"\\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(imageData)
            body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            
            
            
            request.HTTPBody = body
            
            
            var returnData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
            
            var returnString = NSString(data: returnData!, encoding: NSUTF8StringEncoding)
            
            println("returnString \(returnString)") 
            
        }
        if (secondFlashSending){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AllFlashViewController") as! AllFlashViewController
            self.presentViewController(vc, animated: false, completion: nil)
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("FlashCardViewController") as! FlashCardViewController
            vc.currentCards = currentCards;
            vc.event = event;
            self.presentViewController(vc, animated: false, completion: nil)
        }

    }
    
    @IBOutlet var back: UIButton!
    @IBAction func backk(sender: AnyObject) {
        if (secondFlashSending){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("AllFlashViewController") as! AllFlashViewController
            self.presentViewController(vc, animated: false, completion: nil)
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("FlashCardViewController") as! FlashCardViewController
            vc.currentCards = currentCards;
            vc.event = event;
            self.presentViewController(vc, animated: false, completion: nil)
        }
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
