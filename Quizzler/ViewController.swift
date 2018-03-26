//
//  ViewController.swift
//  Quizzler
//
//  Created by Yassine Sabeq on 14/03/18.
//  Copyright © 2018 London App Brewery. All rights reserved.

//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allTheQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var scoreNumber : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if ( sender.tag == 1){
            pickedAnswer = true
        }
        else if ( sender.tag == 2){
            pickedAnswer = false
        }
        checkAnswer()
        questionNumber = questionNumber + 1
        nextQuestion()
        
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score : \(scoreNumber)"
        progressLabel.text = "\(questionNumber + 1) /13"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)    
        
    }
    

    func nextQuestion() {
        if ( questionNumber <= 12 ){
            questionLabel.text = allTheQuestions.list[questionNumber].questionText
            updateUI()
        }
        else {
            let alert = UIAlertController(title: "Quiz finished", message: "congratulations you've reached the end of this quiz. your score is \(scoreNumber). want to start over ?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            self.present(alert, animated: true, completion: nil)
            // updateUI
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allTheQuestions.list[questionNumber].answer
        if (correctAnswer == pickedAnswer) {
            scoreNumber = scoreNumber + 100
            ProgressHUD.showSuccess("Got it")
            //print ("you got it mate")
        }
        else {
            ProgressHUD.showError("Wrong !")
            //print ("hard luck mate")
        }
        
    }
    
    
    func startOver() {
       questionNumber = 0
        scoreNumber = 0
        nextQuestion()
    }
    

    
}
