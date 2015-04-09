//
//  ViewController.swift
//  Memory Moments
//
//  Created by Jack Phillips on 3/28/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var headForCode: UILabel!
    @IBOutlet var ActualCode: UILabel!
    @IBOutlet var Done: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let file = "setUpDone.txt"
        
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            
            //reading
            let text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
            println(text2)
            
            if(text2 == "YesPas"){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("calenderPatientView") as UIViewController
                self.presentViewController(vc, animated: false, completion: nil)
            }
            else if(text2 == "YesCar"){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("CareGiversViewController") as UIViewController
                self.presentViewController(vc, animated: false, completion: nil)
            }
            
            // Do any additional setup after loading the view, typically from a nib.
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func patientSetUp(sender: AnyObject) {
        
        let idfile = "PID.txt"
        let fileC = "setUpDone.txt"
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let pathID = dir.stringByAppendingPathComponent(idfile);
            let pathDone = dir.stringByAppendingPathComponent(fileC);
            var id: String = "";
            var url: NSURL = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/createuser.php")!
            var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
            var bodyData = "usertype=patient"
            request.HTTPMethod = "POST"
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
                {
                    (response, data, error) in
                    println("\(data)")
                    //makes sure that the data base actually sent something back
                    if(data == nil){
                        print("Server connection failed");
                        return;
                    }
                    var jsonError: NSError?
                    if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? NSDictionary {
                        id = json["userid"] as String;
                    }else{
                        print("Fail to pull data correctly")
                    }
                    
                    print("\(id) sdlkjfalsdjf");
                    
                    id.writeToFile(pathID, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
                    //writing that it's complete
                    let text = "YesPas"
                    text.writeToFile(pathDone, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
                    
                    //shows view for connection
                    self.ActualCode.text = id;
                    self.headForCode.hidden = false;
                    self.ActualCode.hidden = false;
                    self.Done.hidden = false;
            }

            
            
            
            
        }
        
    }

    @IBAction func careGiverSetUp(sender: AnyObject) {
        println("Here");
        let idfile = "CID.txt"
        let fileC = "setUpDone.txt"
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let pathID = dir.stringByAppendingPathComponent(idfile);
            let pathDone = dir.stringByAppendingPathComponent(fileC);
            var id: String = "";
            var url: NSURL = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/createuser.php")!
            var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
            var bodyData = "usertype=caretaker"
            request.HTTPMethod = "POST"
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
                {
                    (response, data, error) in
                    println("\(data)")
                    //makes sure that the data base actually sent something back
                    if(data == nil){
                        print("Server connection failed");
                        return;
                    }
                    var jsonError: NSError?
                    if let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? NSDictionary {
                        id = json["userid"] as String;
                    }else{
                        print("Fail to pull data correctly")
                    }
                    
                    print("\(id) sdlkjfalsdjf");
                    
                    id.writeToFile(pathID, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("connect") as connect
                    vc.cid = id;
                    self.presentViewController(vc, animated: false, completion: nil)
                
            }
            
            
            
            
            
        }

    }
    @IBAction func Done(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("calenderPatientView") as UIViewController
        self.presentViewController(vc, animated: false, completion: nil)
    }

}

