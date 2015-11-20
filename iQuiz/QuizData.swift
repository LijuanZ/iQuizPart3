//
//  QuizData.swift
//  iQuiz
//
//  Created by iGuest on 11/10/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

let urlStr: String = "http://tednewardsandbox.site44.com/questions.json"
var myQuizData: QuizData = QuizData(sourceUrl: urlStr)

class QuizData {
    var sourceUrl: String
    var questionSetArr: [QuestionSet]
    init(sourceUrl: String) {
        self.sourceUrl = sourceUrl
        self.questionSetArr = [QuestionSet]()
        self.getJsonFromUrl(self.sourceUrl)
    }
    
    func httpGet(request: NSURLRequest!, callback: (NSString, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
                callback(result, nil)
            }
        }
        task.resume()
    }
    
    func writeToDocumentsFile(fileName: String, value: NSData) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsPath.stringByAppendingPathComponent(fileName)
        //var error: NSError?
        value.writeToFile(path, atomically: true)
    }
    
    func readFromDocumentsFile(fileName: String) -> NSData? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsPath.stringByAppendingPathComponent(fileName)
        let checkValidation = NSFileManager.defaultManager()
        //var error: NSError?
        var result: NSData?
        
        if checkValidation.fileExistsAtPath(path) {
            result = NSData(contentsOfFile: path)
        } else {
            NSLog("Error: \(fileName) does not exist")
        }
        return result
    }
    
    func getJsonFromUrl(urlStr: String) -> Void {
        let fileName = "quizQuestions.txt"
        let url = NSURL(string: urlStr)
        if url != nil {
            let request = NSMutableURLRequest(URL: url!)
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request) {
                (data, response, error) -> Void in
                if error != nil {
                    //Failed to get data from http request
                    print(error)
                    print("Fail to get data from URL, read data from local storage")
                    //Read data from local storage if exist
                    let dataFromFile = self.readFromDocumentsFile(fileName)
                    if dataFromFile != nil {
                        self.questionSetArr = self.parseJSONToQuestions(dataFromFile!)
                    } else {
                        print("Failed to read data from \(fileName)")
                    }
                    
                } else {
                    //Get data successfully, store JSON data to local storage
                    print("Get data from URL successfully")
                    
                    //Store data to local storage
                    self.writeToDocumentsFile(fileName, value: data!)
                    
                    //parse JSON
                    self.questionSetArr = self.parseJSONToQuestions(data!)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("mainViewController") as! ViewController
                    if let tableView = vc.tableView {
                        tableView.reloadData()
                    }
                }
            }
            

            
            
            task.resume()
        } else {
            NSLog("Invalid URL")
        }

    }
    
    func parseJSONToQuestions(data: NSData) -> [QuestionSet] {
        var questionSetArr: [QuestionSet] = [QuestionSet]()
        do {
            let resultJSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            let resultArray = resultJSON as? NSArray
            
            for jsonObjectString in resultArray! {
                let questionSet: QuestionSet = QuestionSet()
                questionSet.title = (jsonObjectString["title"]!) as! String
                questionSet.desc = (jsonObjectString["desc"]!) as! String
                let quesArr = jsonObjectString["questions"]! as! NSArray
                var questions: [Question] = [Question]()
                
                for questionString in quesArr {
                    var answers: [String] = [String]()
                    let ansArr = questionString["answers"]! as! NSArray
                    for ans in ansArr {
                        answers.append(ans as! String)
                    }

                    let question: Question = Question(questionBody: questionString["text"]! as! String, options: answers, correctAnswer: Int(questionString["answer"]! as! String)!)

                    questions.append(question)
                }
                
                questionSet.questions = questions
                questionSetArr.append(questionSet)
                
            }
            
        } catch _{
            print("Received JSON is not well formatted!")
        }
        
        return questionSetArr
    }

}



