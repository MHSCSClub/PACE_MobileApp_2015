//
//  FlashcardviewingViewController.swift
//  Memory Moments
//
//  Created by Jack Phillips on 4/13/15.
//  Copyright (c) 2015 Jack Phillips. All rights reserved.
//

import UIKit

class FlashcardviewingViewController: UIViewController {
    var event = [(Int(), NSDate(), String(), String(), String())];
    @IBOutlet var Image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var info: UITextView!
    var currentCards = [Flashcards]()
    var card: Flashcards!
    override func viewDidLoad() {
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
    @IBAction func back(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("FlashCardViewController") as! FlashCardViewController
        vc.currentCards = currentCards;
        vc.event = event;
        self.presentViewController(vc, animated: false, completion: nil)
    }
    @IBAction func Add(sender: AnyObject) {
        currentCards.append(card);
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("FlashCardViewController") as! FlashCardViewController
        vc.currentCards = currentCards;
        vc.event = event;
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
