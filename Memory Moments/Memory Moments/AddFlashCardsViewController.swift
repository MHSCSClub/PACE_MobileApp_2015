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
        let filenames = "picture.jpeg"
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(filenames);
            let content: NSData = UIImageJPEGRepresentation(imagePerson.image, 1.0)
            content.writeToFile(path, atomically: true)
        }

        var url: NSURL = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/createflashcard.php")!
        var imageData :NSData = UIImageJPEGRepresentation(imagePerson.image, 1.0);
        var request: NSMutableURLRequest?
        let HTTPMethod: String = "POST"
        var timeoutInterval: NSTimeInterval = 60
        var HTTPShouldHandleCookies: Bool = false
        
        request = NSMutableURLRequest(URL: url)
        request!.HTTPMethod = HTTPMethod
        request!.timeoutInterval = timeoutInterval
        request!.HTTPShouldHandleCookies = HTTPShouldHandleCookies
        
        
        let boundary = "----------SwIfTeRhTtPrEqUeStBoUnDaRy"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request!.setValue(contentType, forHTTPHeaderField:"Content-Type")
        var body = NSMutableData();
        
        
        let tempData = NSMutableData()
        let fileName = filenames
        let parameterName = "userfile"
        
        
        let mimeType = "application/octet-stream"
        
        tempData.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        let fileNameContentDisposition = "filename=\"\(fileName)\""
        let contentDisposition = "Content-Disposition: form-data; name=\"\(parameterName)\"; \(fileNameContentDisposition)\r\n"
        tempData.appendData(contentDisposition.dataUsingEncoding(NSUTF8StringEncoding)!)
        tempData.appendData("Content-Type: \(mimeType)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        tempData.appendData(imageData)
        tempData.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        body.appendData(tempData)
        
        body.appendData("\r\n--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        var bodyData = "pid=\(pid)&time=\(date)&type=\(typeOptions[Type.selectedRowInComponent(0)])&title=\(eventTitle.text)&description=\(textField.text)&fclen=\(currentCards.count)"
        request!.setValue("\(body.length)", forHTTPHeaderField: "Content-Length")
        request!.HTTPBody = body
        
        
        
        var vl_error :NSErrorPointer = nil
        var responseData  = NSURLConnection.sendSynchronousRequest(request!,returningResponse: nil, error:vl_error)
        
        var results = NSString(data:responseData!, encoding:NSUTF8StringEncoding)
        println("finish \(results)")
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
