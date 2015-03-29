//
//  calenderPatientView.swift
//  Memory Moments
//
//  Created by Jack Phillips on 3/28/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

//This is the main page class for the Pasient d

import UIKit

class calenderPatientView: UIViewController {

    @IBOutlet var currentDateText: UILabel! //Var for current date box
    //vars for the date
    var date: NSDate!
    var calendar: NSCalendar!
    var components: NSDateComponents!
    var daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
    var dayString = ["Sun" , "Mon", "Tue", "Wen","Thu","Fri","Sat"];
    
    //screen demintions
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gets current date
        date = NSDate()
        calendar = NSCalendar.currentCalendar()
        components = calendar.components(.DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit | .CalendarUnitWeekday,fromDate: date);
        let dateText = "\(components.month)/\(components.day)/\(components.year)";
        currentDateText.text = dateText;
        makeCalendar()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func makeCalendar(){
        let screenWidth = screenSize.width
        
        //displays the days of week
        for i in 0...6 {
            var days = UILabel(frame: CGRect(x: (CGFloat(i) * screenWidth * CGFloat(0.1428)), y: 90, width: (screenWidth * CGFloat(0.1428)), height: 30))
            days.layer.borderWidth = 0.5;
            days.textAlignment = NSTextAlignment.Center;
            days.layer.borderColor = UIColor.blackColor().CGColor!;
            days.text = dayString[i];
            self.view.addSubview(days);
        }
    
        
        //Displays Days around the current day
        var temp = 0;
        var day = components.day - (components.weekday-1);
        
        for i in 0...13 {
            if(day < 1) {
                day = daysInMonth[components.month - 2] - temp;
                temp++;
            }
            else if(day > daysInMonth[components.month - 1]){
                day = 1;
            }
            if(components.day == day) {
                //prints current day
                var current = UILabel(frame: CGRect(x: (CGFloat(components.weekday-1) * screenWidth * CGFloat(0.1428)), y: 120, width: (screenWidth * CGFloat(0.1428)), height: 50))
                current.backgroundColor = UIColor.redColor();
                current.layer.borderWidth = 0.5;
                current.textAlignment = NSTextAlignment.Center;
                current.textColor = UIColor.whiteColor();
                current.layer.borderColor = UIColor.blackColor().CGColor!;
                current.text = "\(day)";
                self.view.addSubview(current);
            }
            else{//print everyother day
                //works to create the next line and to make sure that is starts from the begining
                var a = 0;
                var b = i;
                if(i > 6){
                    a = 1;
                    b -= 7;
                }
                var days = UILabel(frame: CGRect(x: (CGFloat(b) * screenWidth * CGFloat(0.1428)), y: (CGFloat(120) + (CGFloat(50) * CGFloat(a))), width: (CGFloat(screenWidth) * CGFloat(0.1428)), height: 50));
                days.layer.borderWidth = 0.5;
                days.textAlignment = NSTextAlignment.Center;
                days.layer.borderColor = UIColor.blackColor().CGColor!;
                days.text = "\(day)";
                self.view.addSubview(days);
                
            }
            day++;
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
