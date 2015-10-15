//
//  flash2ViewController.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/17/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit

class flash2ViewController: UIViewController {
    @IBOutlet var name: UILabel!
    @IBOutlet var Image: UIImageView!
    @IBOutlet var info: UITextView!
    var card: Flashcards!
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        name.text = card.name;
        info.text = card.info
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent("picture\(card.fcid).jpg");
            Image.image = UIImage(named: path)
        }
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
