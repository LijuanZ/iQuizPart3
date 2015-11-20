//
//  QuestionSet.swift
//  iQuiz
//
//  Created by iGuest on 11/9/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class QuestionSet: NSObject {
    var title: String
    var desc: String
    var questions: [Question]
    
    init(title: String, desc: String, questions: [Question]) {
        self.title = title
        self.desc = desc
        self.questions = questions
    }
    
    override init() {
        self.title = ""
        self.desc = ""
        self.questions = []
    }

}
