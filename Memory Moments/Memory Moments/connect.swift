//
//  connect.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/8/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit

class connect: UIViewController {

    @IBOutlet var TextInput: UITextField!
    var cid: String!;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func Connect(sender: AnyObject) {
        let idfile = "PID.txt"
        let fileC = "setUpDone.txt"
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let pathID = dir.stringByAppendingPathComponent(idfile);
            let pathDone = dir.stringByAppendingPathComponent(fileC);
            var id: String = "";
            var url: NSURL = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/linkpatient.php")!
            var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
            var bodyData = "pid=\(TextInput.text)&cid=\(cid)"
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
                    id = self.TextInput.text;
                    id.writeToFile(pathID, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
                    //writing that it's complete
                    let text = "YesCar"
                    text.writeToFile(pathDone, atomically: false, encoding: NSUTF8StringEncoding, error: nil);
                    print("Sucsess");
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("CareGiversViewController") as! UIViewController
                    self.presentViewController(vc, animated: false, completion: nil)
            }
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
