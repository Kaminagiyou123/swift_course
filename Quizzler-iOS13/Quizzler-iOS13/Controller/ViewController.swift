//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var quizBrain = QuizBrain()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
       
    }


    @IBAction func answerButtonClicked(_ sender: UIButton) {
       
        let userAnswer=sender.currentTitle!
        
        if  quizBrain.checkAnswer(userAnswer){
            sender.backgroundColor=UIColor.green
            print("correct")
        } else {
            sender.backgroundColor=UIColor.red
            print("wrong")
        }
        
        
        quizBrain.updateQuestionNumber()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    

    }
    
    @objc func updateUI(){
        questionLabel.text=quizBrain.getQuestionText()
        progressBar.progress=quizBrain.getProgress()
        scoreLabel.text="score:\(quizBrain.getScore())"
        trueButton.backgroundColor=UIColor.clear
        falseButton.backgroundColor=UIColor.clear
        
        
        
    }
}

