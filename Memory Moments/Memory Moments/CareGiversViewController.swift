import UIKit
import CoreData
import Foundation

class CareGiversViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var firsttime: Bool = true;
    var NewEvents = [(Int(), NSDate(), String(), String(), String())];
    var Events = [MainData]()
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var logTableView = UITableView(frame: CGRectZero, style: .Plain)
    
    @IBOutlet var currentDateText: UILabel! //Var for current date box
    //vars for the date
    var date: NSDate!
    var calendar: NSCalendar!
    var components: NSDateComponents!
    var daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
    
    //screen demintions
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use optional binding to confirm the managedObjectContext
        
        
        if let moc = self.managedObjectContext {
            postRequest()
            NSTimeZone.resetSystemTimeZone()
            /*let dates = "2015-04-09 21:50:00"
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.timeZone = NSTimeZone.defaultTimeZone()
            let date1 = formatter.dateFromString(dates)
            MainData.createInManagedObjectContext(moc, evtid: 100, time: date1!, type: "Cool", descrition: "cool", Title: "FUN")
            println(date1!)
            
            
            */
            println(NSDate())
            
            var viewFrame = self.view.frame
            //Sets up the Table View
            viewFrame.origin.y += 20
            viewFrame.size.height -= 65;
            logTableView.frame = viewFrame
            logTableView.scrollEnabled = true;
            logTableView.rowHeight = 70;
            // Add the table view to this view controller's view
            self.view.addSubview(logTableView)
            // Here, we tell the table view that we intend to use a cell we're going to call "LogCell"
            logTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "LogCell")
            
            // This tells the table view that it should get it's data from this class, ViewController
            logTableView.dataSource = self
            logTableView.dataSource = self
            logTableView.delegate = self
            
            
        }
        //gets current date
        date = NSDate()
        calendar = NSCalendar.currentCalendar()
        components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitWeekday,fromDate: date);
        
        //save()
        fetchLog()
        
        
        
        // Do any additional setup after loading the view.
        
        //timmer that refresh page after some time
        var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    //updates screen
    func update() {
        postRequest()
    }
    //Gets the data from Core Data
    func fetchLog() {
        var month: String = "\(components.month)";
        var day: String = "\(components.day + 1)"
        println(day)
        
        
        if (count(month) < 2) {
            month = "0\(components.month)"
        }
        if (count(day) < 2){
            day = "0\(components.day+1)"
            if(components.day == daysInMonth[components.month-1]){
                day = "01"
            }
        }
        let dates = "\(components.year)-\(month)-\(day) 00:00:00"
        println(dates)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        let date1 = formatter.dateFromString(dates)
        
        let fetchRequest = NSFetchRequest(entityName: "MainData")
        // Create a sort descriptor object that sorts on the "title"
        // property of the Core Data object
        let sortDescriptor = NSSortDescriptor(key: "time", ascending: true)
        
        //predicate
        let predicate1 = NSPredicate(format: "time > %@" , NSDate())
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate1
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [MainData] {
            Events = fetchResults
            
        }
        
    }
    //takes in the info from database and adds new idems to core data
    func pullInNewData() {
        fetchLog()
        for (ID, DATE, TYPE, Dis, Title) in NewEvents {
            // Create an individual item
            var used: Bool = false;
            for event in Events {
                if (event.evtid == ID){
                    used = true;
                }
            }
            //makes sure that the element has not been brought in already
            if(!used){
                MainData.createInManagedObjectContext(self.managedObjectContext!, evtid: ID, time: DATE, type: TYPE, descrition: Dis, Title: Title)
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
        return Events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LogCell") as! UITableViewCell
        
        // Get the LogItem for this index
        let envents = Events[indexPath.row]
        let timestamp = NSDateFormatter.localizedStringFromDate(envents.time, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        // Set the title of the cell to be the title of the logItem
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = "\(envents.title)\nDate: \(timestamp)"
        cell.textLabel?.numberOfLines = 2;
        
        return cell
    }
    
    //Clicked Event going to next Page
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("EventViewController") as! EventViewController
        vc.passedData = Events[indexPath.row];
        self.presentViewController(vc, animated: true, completion: nil)
        
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
    
    
    @IBAction func AddEvent(sender: AnyObject) {
        print("AddEvent")
    }
    func postRequest() {
        var pid: String = "";
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent("PID.txt");
            
            //reading to get the PID of person
            pid = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
            println(pid)
        }
        //sets up and makes conection to the database
        var url: NSURL = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/updateevents.php")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        var bodyData = "pid=\(pid)"
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
                    let evtid = event["evtid"] as! Int;
                    let dates = event["time"] as! String;
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    formatter.timeZone = NSTimeZone.systemTimeZone()
                    let date1 = formatter.dateFromString(dates)
                    let type = event["type"] as! String;
                    let title = event["title"] as! String;
                    let descrition = event["description"] as! String;
                    self.NewEvents.append(evtid, date1!, type, descrition, title);
                }
                if (self.firsttime) {
                    self.NewEvents.removeAtIndex(0);
                    self.firsttime = false;
                }
                self.pullInNewData()
                
        }
        
    }
}