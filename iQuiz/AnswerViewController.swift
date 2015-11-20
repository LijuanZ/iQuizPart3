//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/9/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    //Variables to hold data from previous VC
    var receivedQuizData: QuestionSet?
    var studentAnswer = StudentAnswer(questionIndex: 0, selectedOption: 0, correctAnswerCount: 0)
    
    //Segues
    let answerToQuestionSegueIdentifier = "answerToQuestion"
    let toFinishSegueIdentifier = "toFinish"
    let toMainSegueIdentifier = "answerToMain"


    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var studentAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let curQuestion = receivedQuizData!.questions[studentAnswer.questionIndex]
        if studentAnswer.selectedOption == curQuestion.correctAnswer {
            resultLabel.text = "Correct Answer!"
            studentAnswer.correctAnswerCount += 1
        }
        else {
            resultLabel.text = "Wrong Answer"
        }
        
        if studentAnswer.selectedOption == 0 {
            studentAnswerLabel.text = "You did not select any answer."
        } else {
            studentAnswerLabel.text = "Your Answer: " + curQuestion.options[studentAnswer.selectedOption - 1]
        }
        correctAnswerLabel.text = "Correct Answer: " + curQuestion.options[curQuestion.correctAnswer - 1]

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
                
                studentAnswer.questionIndex += 1
                
                //Finished all questions
                if studentAnswer.questionIndex >= receivedQuizData!.questions.count {
                    self.performSegueWithIdentifier(toFinishSegueIdentifier, sender: self)
                }
                    //There are questions to answer
                else {
                    self.performSegueWithIdentifier(answerToQuestionSegueIdentifier, sender: self)
                }
            }
        }
    }

    @IBAction func clickNext(sender: UIButton) {
        studentAnswer.questionIndex += 1
        
        //Finished all questions
        if studentAnswer.questionIndex >= receivedQuizData!.questions.count {
            self.performSegueWithIdentifier(toFinishSegueIdentifier, sender: self)
        }
        //There are questions to answer
        else {
            self.performSegueWithIdentifier(answerToQuestionSegueIdentifier, sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == answerToQuestionSegueIdentifier {
            if let destination = segue.destinationViewController as? QuestionViewController {
                //Pass question set and student answer to next view
                destination.receivedQuizData = receivedQuizData
                destination.studentAnswer = studentAnswer
            }
        }
        else if segue.identifier == toFinishSegueIdentifier{
            if let destination = segue.destinationViewController as? FinishedViewController {
                destination.receivedQuizData = receivedQuizData
                destination.studentAnswer = studentAnswer
            }
        }
    }
    
}
