//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Keran Zheng on 11/8/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    //The variables will hold the data passed from ViewController
    var receivedQuizData: QuestionSet?
    var curQuestion: Question?
    var studentAnswer = StudentAnswer(questionIndex: 0, selectedOption: 0, correctAnswerCount: 0)
    
    //Segues
    let optionCellIdentifier = "optionCell"
    let questionToAnswerSegueIdentifier = "questionToAnswer"
    let toMainSegueIdentifier = "questionToMain"

    @IBOutlet weak var currentQuestion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set receivedCellIndex using data passed from previous view controller
        if receivedQuizData != nil {
            if studentAnswer.questionIndex < receivedQuizData!.questions.count {
                curQuestion = receivedQuizData!.questions[studentAnswer.questionIndex]
                currentQuestion.text = curQuestion!.questionBody
            }
        }
        
        //Left swipe
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwipe)
        
        //Right swipe
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func respondToSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == UISwipeGestureRecognizerDirection.Right {
                self.performSegueWithIdentifier(toMainSegueIdentifier, sender: self)
            }
            else if swipeGesture.direction == UISwipeGestureRecognizerDirection.Left {
                self.performSegueWithIdentifier(questionToAnswerSegueIdentifier, sender: self)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if curQuestion != nil {
            return curQuestion!.options.count
        }
        else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(optionCellIdentifier) as UITableViewCell!
        
        //Add text
        let textLabel = cell.viewWithTag(2) as! UILabel
        textLabel.text = curQuestion!.options[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Update student answer of the current question
        studentAnswer.selectedOption = indexPath.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == questionToAnswerSegueIdentifier {
            if let destination = segue.destinationViewController as? AnswerViewController {
                //Pass question set and student answer to next view
                destination.receivedQuizData = receivedQuizData
                destination.studentAnswer = studentAnswer
            }
        }
        
    }


}
