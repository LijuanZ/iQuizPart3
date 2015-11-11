//
//  Question.swift
//  iQuiz
//
//  Created by iGuest on 11/9/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class Question: NSObject {
    let questionBody: String
    let options: [String]
    
    //correctAnswer is the index of the answer in options
    let correctAnswer: Int
    
    init(questionBody: String, options: [String], correctAnswer: Int) {
        self.questionBody = questionBody
        self.options = options
        self.correctAnswer = correctAnswer
    }
}
