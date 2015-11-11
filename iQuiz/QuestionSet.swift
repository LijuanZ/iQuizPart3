//
//  QuestionSet.swift
//  iQuiz
//
//  Created by iGuest on 11/9/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class QuestionSet: NSObject {
    var subject: String
    var questions: [Question]
    
    init(subject: String, questions: [Question]) {
        self.subject = subject
        self.questions = questions
    }
    
    override init() {
        self.subject = ""
        self.questions = []
    }

}
