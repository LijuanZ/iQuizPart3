//
//  ViewController.swift
//  iQuiz
//
//  Created by Keran Zheng on 11/2/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func showAlert(sender: UIButton) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    let tableIdentifier = "TableIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableIdentifier) as UITableViewCell!
        
//        if cell == nil {
//            //NSLog("Generate cell")
//            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: tableIdentifier)
//        }
        
        //Add image
        let imageView = cell.viewWithTag(1) as! UIImageView
        let imageBook = UIImage(named: "bookPurple")
        imageView.image = imageBook
        let imageBookHighlighted = UIImage(named: "bookGreen")
        imageView.highlightedImage = imageBookHighlighted

        //Add text
        let textLabel = cell.viewWithTag(2) as! UILabel
        textLabel.text = subjects[indexPath.row]
        //cell.textLabel?.font = UIFont.boldSystemFontOfSize(30)
        
        return cell
    }
    
    
}

