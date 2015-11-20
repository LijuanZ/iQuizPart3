//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/17/15.
//  Copyright © 2015 Lijuan Zhang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var quizData: QuizData?
    
    let exitSettings = "exitSettings"

    @IBOutlet weak var inputUrl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshQuiz(sender: UIButton) {
        quizData = QuizData(sourceUrl: inputUrl.text!)
    }

}
