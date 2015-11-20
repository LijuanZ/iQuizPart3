//
//  ViewController.swift
//  iQuiz
//
//  Created by Keran Zheng on 11/2/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func showAlert(sender: UIButton) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    let images = [UIImage(named: "mathGreen"), UIImage(named: "heroGreen"), UIImage(named: "scienceGreen")]
    let highlightImages = [UIImage(named: "mathPurple"), UIImage(named: "heroPurple"), UIImage(named: "sciencePurple")]
    
    //Quiz data for all of the subjects
    var quizData: QuizData = myQuizData
    var studentAnswer = StudentAnswer(questionIndex: 0, selectedOption: 0, correctAnswerCount: 0)
    
    let tableIdentifier = "TableIdentifier"
    let quizToQuestionSegueIdentifier = "quizToQuestion"
    let toSettingsSegueIdentifier = "toSettings"
    
    var refreshControl:UIRefreshControl!
    
    
    func refresh(sender:AnyObject)
    {
        // Code to refresh table view
        print("Pull to refresh")
        myQuizData.getJsonFromUrl(myQuizData.sourceUrl)
        tableView.reloadData()
        
        self.refreshControl.endRefreshing()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //quizData = myQuizData
        
        //Pull to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exit(segue: UIStoryboardSegue) {
        print("Move back")

        if let sourceVC = segue.sourceViewController as? SettingsViewController {
            if sourceVC.quizData != nil && sourceVC.quizData!.questionSetArr.count > 0 {
                //Exit from setting, need to reload tableView since myQuizData is updated
                myQuizData = sourceVC.quizData!
                quizData = myQuizData
                
                //Update tableView
                tableView.reloadData()
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle {
        // This *forces* a popover to be displayed on the iPhone
        return .None
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizData.questionSetArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableIdentifier) as UITableViewCell!
        
        //Add image
        let imageView = cell.viewWithTag(1) as! UIImageView
        //let imageBook = UIImage(named: "bookPurple")
        imageView.image = images[indexPath.row]
        //let imageBookHighlighted = UIImage(named: "bookGreen")
        imageView.highlightedImage = highlightImages[indexPath.row]

        //Add text
        let textLabel = cell.viewWithTag(2) as! UILabel
        textLabel.text = quizData.questionSetArr[indexPath.row].title
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == quizToQuestionSegueIdentifier {
            if let destination = segue.destinationViewController as? QuestionViewController {
                if let cellIndexPath = tableView.indexPathForSelectedRow {
                    //The set of questions based on selection of subject
                    destination.receivedQuizData = quizData.questionSetArr[cellIndexPath.row]
                    
                    //Student's answer, initialized with 0s
                    destination.studentAnswer = studentAnswer
                }
            }
        }
        
    }
    
}

