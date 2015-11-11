//
//  QuizData.swift
//  iQuiz
//
//  Created by iGuest on 11/10/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

//Maths questions
let mathQuestion1 = Question(questionBody: "5 + 9 = ?", options: ["12", "13", "14", "15"], correctAnswer: 2)
let mathQuestion2 = Question(questionBody: "5 * 9 = ?", options: ["45", "40", "63", "36"], correctAnswer: 0)
let mathQuestion3 = Question(questionBody: "3 + 3 * 2 = ?", options: ["5", "7", "8", "9"], correctAnswer: 3)
let mathQuestion4 = Question(questionBody: "What is the average of 4, 5, 6, 7, 8, 9 ?", options: ["5.5", "6.5", "7.5", "8.5"], correctAnswer: 1)

//Science questions
let scienceQuestion1 = Question(questionBody: "What is fire?", options: ["One of the four classical elements", "A magical reaction given to us by God", "A band that hasn't yet been discovered", "Fire! Fire! Fire! heh-heh"], correctAnswer: 0)

//Marvel Super Heroes questions
let mshQuestion1 = Question(questionBody: "Who founded the X-Men?", options: ["Tony Stark", "The X-Institute", "Professor X", "Erik Lensherr"], correctAnswer: 2)
let mshQuestion2 = Question(questionBody: "How did Spider-Man get his powers?", options: ["He was bitten by a radioactive spider", "He ate a radioactive spider", "He is a radioactive spider", "He looked at a radioactive spider"], correctAnswer: 0)

let questionSetOfMaths: QuestionSet = QuestionSet(subject: "Mathematics", questions: [mathQuestion1, mathQuestion2, mathQuestion3, mathQuestion4])
let questionSetOfScience: QuestionSet = QuestionSet(subject: "Science", questions: [scienceQuestion1])
let questionSetOfMarvelSuperHeroes: QuestionSet = QuestionSet(subject: "Marvel Super Heroes", questions: [mshQuestion1, mshQuestion2])

let quizSubjects = [questionSetOfMaths, questionSetOfMarvelSuperHeroes, questionSetOfScience]