//
//  ViewController.swift
//  iQuiz
//
//  Created by Keran Zheng on 11/2/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func showAlert(sender: UIButton) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    let images = [UIImage(named: "mathGreen"), UIImage(named: "heroGreen"), UIImage(named: "scienceGreen")]
    let highlightImages = [UIImage(named: "mathPurple"), UIImage(named: "heroPurple"), UIImage(named: "sciencePurple")]
    //private let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    //Quiz data for all of the subjects
    let subjects: [QuestionSet] = quizSubjects
    var studentAnswer = StudentAnswer(questionIndex: 0, selectedOption: 0, correctAnswerCount: 0)
    
    let tableIdentifier = "TableIdentifier"
    let quizToQuestionSegueIdentifier = "quizToQuestion"
    
    var chosenQuizIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        //Add image
        let imageView = cell.viewWithTag(1) as! UIImageView
        //let imageBook = UIImage(named: "bookPurple")
        imageView.image = images[indexPath.row]
        //let imageBookHighlighted = UIImage(named: "bookGreen")
        imageView.highlightedImage = highlightImages[indexPath.row]

        //Add text
        let textLabel = cell.viewWithTag(2) as! UILabel
        textLabel.text = subjects[indexPath.row].subject
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == quizToQuestionSegueIdentifier {
            if let destination = segue.destinationViewController as? QuestionViewController {
                if let cellIndexPath = tableView.indexPathForSelectedRow {
                    //The set of questions based on selection of subject
                    destination.receivedQuizData = subjects[cellIndexPath.row]
                    
                    //Student's answer, initialized with 0s
                    destination.studentAnswer = studentAnswer
                }
            }
        }
    }
    
    
}

