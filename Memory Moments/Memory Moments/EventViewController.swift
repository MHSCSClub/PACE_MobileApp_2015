//
//  EventViewController.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/6/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    var passedData: MainData!;
    override func viewDidLoad() {
        super.viewDidLoad()
        var label = UILabel(frame: CGRect(x: 50, y: 50, width: 700, height: 700))
        label.textColor = UIColor.blackColor();
        label.numberOfLines = 4;
        let timestamp = NSDateFormatter.localizedStringFromDate(passedData.time, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        
        var calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitWeekday,fromDate: passedData.time);
        let dateText = "\(components.month)/\(components.day)/\(components.year) at \(components.hour):\(components.minute)";
        label.text = "\(passedData.title)\n \(timestamp) \n \(passedData.descrition)\n \(passedData.type)"
        self.view.addSubview(label);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
