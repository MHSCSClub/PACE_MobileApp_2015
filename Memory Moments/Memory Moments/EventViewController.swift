//
//  EventViewController.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/6/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit
import CoreData
class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var backButton: UIButton!
    @IBOutlet var name: UILabel!
    @IBOutlet var info: UITextView!
    @IBOutlet var flashView: UIView!
    @IBOutlet var personPic: UIImageView!
    @IBOutlet var evttitle: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var descrition: UILabel!
    @IBOutlet var infoevent: UITextView!
    
    var passedData: MainData!;
    var NewEvents = [(Int(), String(), String())];
    var Flash = [Flashcards]()
    var need = [Int]()
    var neededFlash = [Flashcards]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var logTableView = UITableView(frame: CGRectZero, style: .Plain)
    override func viewDidLoad() {
        postRequest()
        super.viewDidLoad()
        var label = UILabel(frame: CGRect(x: 50, y: 50, width: 700, height: 700))
        label.textColor = UIColor.blackColor();
        label.numberOfLines = 4;
        let timestamp = NSDateFormatter.localizedStringFromDate(passedData.time, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        var viewFrame = self.view.frame
        //Sets up the Table View
        viewFrame.origin.y += 300
        viewFrame.size.height -= 300;
        logTableView.frame = viewFrame
        logTableView.rowHeight = 90;
        logTableView.scrollEnabled = true;
        // Add the table view to this view controller's view
        self.view.addSubview(logTableView)
        personPic.contentMode = .ScaleAspectFit
        
        
        // Here, we tell the table view that we intend to use a cell we're going to call "LogCell"
        logTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "LogCell")
        
        // This tells the table view that it should get it's data from this class, ViewController
        logTableView.dataSource = self
        logTableView.delegate = self

        
        /*var calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitWeekday,fromDate: passedData.time);
        let dateText = "\(components.month)/\(components.day)/\(components.year) at \(components.hour):\(components.minute)";*/
        //label.text = "\(passedData.title)\n \(timestamp) \n \(passedData.descrition)\n \(passedData.type)"
        self.view.addSubview(label);
        // Do any additional setup after loading the view.
        evttitle.text = "\(passedData.title)"
        time.text = "\(NSDateFormatter.localizedStringFromDate(passedData.time, dateStyle: .MediumStyle, timeStyle: .ShortStyle))"
        infoevent.text = passedData.descrition
        self.view.bringSubviewToFront(infoevent)
        var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("update"), userInfo: nil, repeats: false)
    }
    @IBAction func EXIT(sender: AnyObject) {
        flashView.hidden = true;
        self.view.sendSubviewToBack(flashView)
    }
    func update(){
        logTableView.reloadData()
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
            getNeeded()
            
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
        return neededFlash.count
    }
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("LogCell") as! UITableViewCell
            
            // Get the LogItem for this index
            let envents = neededFlash[indexPath.row]
            
            // Set the title of the cell to be the title of the logItem
            cell.textLabel?.text = envents.name
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
                let dir = dirs[0] //documents directory
                let path = dir.stringByAppendingPathComponent("picture\(envents.fcid).jpg");
                cell.imageView?.image = UIImage(named: path)
            }
            return cell
    }
    
    //Clicked Event going to next Page
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let flash = neededFlash[indexPath.row]
        name.text = flash.name
        info.text = flash.info
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent("picture\(flash.fcid).jpg");
            personPic.image = UIImage(named: path)
        }
        flashView.backgroundColor = UIColor.grayColor()
        flashView.hidden = false;
        self.view.bringSubviewToFront(flashView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getNeeded(){
        for evt in Flash {
            for id in need{
                if id == evt.fcid {
                    neededFlash.append(evt)
                }
            }
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
        var url: NSURL = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/updateflashcard.php")!
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
                self.getAttachFlash()
                self.pullInNewData()
                
        }
        
    }
    func getPicture(fcid: Int) {
        let url = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/getpicture.php?fcid=\(fcid)")!
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
    func getAttachFlash(){
        //sets up and makes conection to the database
        var url: NSURL = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/getflashcard.php")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        var bodyData = "evtid=\(passedData.evtid)"
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
                    self.need.append(fcid);
                    print(self.need)
                    println("HHHHHHHHH")
                }
                self.fetchLog()
                self.logTableView.reloadData()
                
        }
    }

    @IBAction func backAction(sender: AnyObject) {
        let file = "setUpDone.txt"
        
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file);
            
            //reading
            let text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
            println(text2)
            
            if(text2 == "YesPas"){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("calenderPatientView") as! UIViewController
                self.presentViewController(vc, animated: false, completion: nil)
            }
            else if(text2 == "YesCar"){
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
