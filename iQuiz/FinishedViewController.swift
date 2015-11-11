//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Keran Zheng on 11/9/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    
    let toMainSegueIdentifier = "finishToMain"
    
    var receivedQuizData: QuestionSet?
    var studentAnswer = StudentAnswer(questionIndex: 0, selectedOption: 0, correctAnswerCount: 0)

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set description label
        let score: Double = Double(studentAnswer.correctAnswerCount) / Double(receivedQuizData!.questions.count)
        if score <= 0.2 {
            greetingLabel.text = "Keep trying"
        }
        else if score < 0.8 {
            greetingLabel.text = "Not bad"
        }
        else if score < 1{
            greetingLabel.text = "Almost"
        }
        else {
            greetingLabel.text = "Perfect"
        }
        
        // Set score label
        scoreLabel.text = "Your score is: \(studentAnswer.correctAnswerCount) / \(receivedQuizData!.questions.count)"
        
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
        }
    }
    
    @IBAction func clickNext(sender: UIButton) {
        //Back to main list
        self.performSegueWithIdentifier(toMainSegueIdentifier, sender: self)
    }
}
