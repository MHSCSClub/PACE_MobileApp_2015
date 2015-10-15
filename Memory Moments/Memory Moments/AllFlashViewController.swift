//
//  AllFlashViewController.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/17/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit
import CoreData
class AllFlashViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var server = ServerURL();
    var Flash = [Flashcards]()
    var NewEvents = [(Int(), String(), String())];
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var logTableView = UITableView(frame: CGRectZero, style: .Plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        postRequest()
        // Do any additional setup after loading the view.
        var viewFrame = self.view.frame
        //Sets up the Table View
        viewFrame.origin.y += 80
        viewFrame.size.height -= 120;
        logTableView.frame = viewFrame
        logTableView.scrollEnabled = true;
        // Add the table view to this view controller's view
        self.view.addSubview(logTableView)
        // Here, we tell the table view that we intend to use a cell we're going to call "LogCell"
        logTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "LogCell")
        
        // This tells the table view that it should get it's data from this class, ViewController
        logTableView.dataSource = self
        logTableView.dataSource = self
        logTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "Flashcards")
        // Create a sort descriptor object that sorts on the "title"
        // property of the Core Data object
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        //predicate
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Flashcards] {
            Flash = fetchResults
            
        }
        
        
    }
    func pullInNewData() {
        fetchLog()
        for (fcid, name, info) in NewEvents {
            // Create an individual item
            var used: Bool = false;
            for evt in Flash {
                if (evt.fcid == fcid){
                    used = true;
                }
            }
            //makes sure that the element has not been brought in already
            if(!used && count(name) > 0){
                Flashcards.createInManagedObjectContext(self.managedObjectContext!, name: name, fcid: fcid, info: info)
                getPicture(fcid)
            }
        }
        self.fetchLog()
        logTableView.reloadData()
        save()
        
    }
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // How many rows are there in this section?
        // There's only 1 section, and it has a number of rows
        // equal to the number of logItems, so return the count
        return Flash.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LogCell") as! UITableViewCell
        
        // Get the LogItem for this index
        let envents = Flash[indexPath.row]
        
        // Set the title of the cell to be the title of the logItem
        cell.textLabel?.text = envents.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
        
    }
    
    //Clicked Event going to next Page
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("flash2ViewController") as! flash2ViewController
        vc.card = Flash[indexPath.row]
        self.presentViewController(vc, animated: false, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }

    
    func postRequest() {
        var pid: String = "";
        var fcidM: String = "";
        var path2: String!;
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent("PID.txt");
            path2 = dir.stringByAppendingPathComponent("fcid.txt");
            
            //reading to get the PID of person
            pid = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
            fcidM = String(contentsOfFile: path2, encoding: NSUTF8StringEncoding, error: nil)!
            if (fcidM == ""){
                fcidM = "0";
            }
            println(pid)
        }
        //sets up and makes conection to the database
        var url: NSURL = NSURL(string: "\(server.URL)/updateflashcard.php")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        var bodyData = "pid=\(pid)&fcid=\(fcidM)"
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
                var arr: [AnyObject];
                if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [AnyObject] {
                    arr = array;
                }else{
                    arr = [];
                }
                //goes throught the events given from database
                for event in arr {
                    let fcid = event["fcid"] as! Int;
                    let name = event["name"] as! String;
                    let info = event["info"] as! String
                    self.NewEvents.append(fcid, name, info);
                }
                if(self.NewEvents.count != 0){
                    "\(self.NewEvents[self.NewEvents.count - 1].0)".writeToFile(path2, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
                    println("FCID: \(self.NewEvents[self.NewEvents.count - 1].0)")
                }
                print(self.NewEvents[0])/*
                if ("\(self.NewEvents[0]))" == "") {
                self.NewEvents.removeAtIndex(0);
                print(self.NewEvents[0])
                }*/
                self.pullInNewData()
                
        }
        
    }
    func getPicture(fcid: Int) {
        let url = NSURL(string: "\(server.URL)/getpicture.php?fcid=\(fcid)")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "GET"
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                println("")
                if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
                    let dir = dirs[0] //documents directory
                    let path = dir.stringByAppendingPathComponent("picture\(fcid).jpg");
                    data.writeToFile(path, atomically: true)
                }
                
                
        }
    }
    
    @IBAction func createFlash(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddFlashCardsViewController") as! AddFlashCardsViewController
        vc.secondFlashSending = true;
        self.presentViewController(vc, animated: false, completion: nil)
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
