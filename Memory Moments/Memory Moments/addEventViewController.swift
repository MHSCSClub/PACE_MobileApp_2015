//
//  addEventViewController.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/10/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit
import Foundation
class addEventViewController: UIViewController, UIPickerViewDataSource, UITextViewDelegate, UITextFieldDelegate {

    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var textField: UITextView!
    @IBOutlet var Type: UIPickerView!
    var Edit = false;
    var typeOptions = ["Event", "Reminder"]
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self;
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = UIColor.grayColor().CGColor
        eventTitle.delegate = self;
        // Do any additional setup after loading the view.
    }

    @IBAction func addFlash(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("FlashCardViewController") as! UIViewController
        self.presentViewController(vc, animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

    @IBAction func endEdit(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func RemoveKeyBoard(sender: AnyObject) {
        
        eventTitle.resignFirstResponder()
    }
    //required for picker view 
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeOptions.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        println(typeOptions[row])
        return typeOptions[row]
    }
    //connects to database and adds Event
    @IBAction func DoneAdd(sender: AnyObject) {
        var pid: String = "";
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent("PID.txt");
            
            //reading to get the PID of person
            pid = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
            println(pid)
        }
        //fixes the date from the date picker so it's right for the server
        datePicker.timeZone = NSTimeZone.systemTimeZone()
        let time = datePicker.date
        var calendar = NSCalendar.currentCalendar()
        var components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitMinute | .CalendarUnitHour ,fromDate: time);
        var month:String = "\(components.month)"
        var day:String = "\(components.day)"
        var min:String = "\(components.minute)"
        var hour:String = "\(components.hour)"
        if (count(month) < 2) {
            month = "0\(components.month)"
        }
        if (count(day) < 2){
            day = "0\(components.day)"
            
        }
        if (count(min) < 2){
            min = "0\(components.minute)"
        }
        if (count(hour) < 2){
            min = "0\(components.hour)"
        }
        let date: String = "\(components.year)-\(month)-\(day) \(hour):\(min):00"
        print("Date \(date)")
        //sets up and makes conection to the database
        var url: NSURL = NSURL(string: "http://aakatz3.asuscomm.com:8085/mobile/createevent.php")!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        var bodyData = "pid=\(pid)&time=\(date)&type=\(typeOptions[Type.selectedRowInComponent(0)])&title=\(eventTitle.text)&description=\(textField.text)&fclen=0"
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                println("\(data)")
                //makes sure that the data base actually sent something back
                if(data == nil){
                    print("Server connection failed");
                    let alertController = UIAlertController(title: "Problem", message:
                        "Server Connection Problem\nPlease try again", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    return;
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("CareGiversViewController") as! UIViewController
                self.presentViewController(vc, animated: false, completion: nil)
                return;
            }
        let alertController = UIAlertController(title: "Problem", message:
            "Server Connection Problem\nPlease try again", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
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
