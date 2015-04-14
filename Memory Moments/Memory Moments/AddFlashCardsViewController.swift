//
//  AddFlashCardsViewController.swift
//  Memory Moments
//
//  Created by Jadav, Jigar on 4/13/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit

class AddFlashCardsViewController: UIViewController , UITextViewDelegate {
    @IBOutlet weak var InformationBox: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        InformationBox.layer.borderWidth = 1;
        InformationBox.layer.borderColor = UIColor.grayColor().CGColor
        InformationBox.delegate = self;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func keyBoardDown(sender: AnyObject) {
        InformationBox.resignFirstResponder()
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
