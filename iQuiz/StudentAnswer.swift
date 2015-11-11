//
//  StudentAnswer.swift
//  iQuiz
//
//  Created by iGuest on 11/9/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class StudentAnswer: NSObject {
    var questionIndex: Int
    var selectedOption: Int
    
    //Use this variable to track how many correct answers the student made
    var correctAnswerCount: Int
    
    init(questionIndex: Int, selectedOption: Int, correctAnswerCount: Int) {
        self.questionIndex = questionIndex
        self.selectedOption = selectedOption
        self.correctAnswerCount = correctAnswerCount
    }

}
