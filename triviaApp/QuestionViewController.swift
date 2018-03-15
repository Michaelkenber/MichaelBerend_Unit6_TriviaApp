//
//  QuestionViewController.swift
//  triviaApp
//
//  Created by Michael Berend on 12/03/2018.
//  Copyright © 2018 Michael Berend. All rights reserved.
//


import UIKit

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

class QuestionViewController: UIViewController {

    // keep track of curent answer
    var currentAnswer = ""
    var currentAnswers = [String]()

    // create a timer variable
    var countdownTimer: Timer!
    var totalTime = 15
    
    // define an array to hold questions
    var questions = [Question]()
    
    // create outlets for each button
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var questionNrLabel: UILabel!
    
    // create indexing variable for questions
    var questionIndex = 0
    
    // create correct answer count variable
    var correctAnswers: Int = 0
    
    /// get questions from server, update view and start the timer
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionController.shared.fetchQuestionData{ (questions) in
            if let questions = questions {
                self.updateUI(with: questions)
            }}
        startTimer()
    }
    
    
    func updateUI(with questions: [Question]) {
        DispatchQueue.main.async {
            // let global array hold questions
            self.questions = questions
            
            //choose a random question
            let currentQuestionAnswer = questions[Int(arc4random_uniform(UInt32(questions.count)))]
            
            // define the question and answer
            let currentQuestion = currentQuestionAnswer.question
            let answerOption1 = currentQuestionAnswer.answer
            self.currentAnswer = answerOption1
        
            // update label with nr quesiton
            self.questionNrLabel.text = "Question #\(self.questionIndex+1)"
            
            // define 3 other random question answers
            let answerOption2 = questions[Int(arc4random_uniform(UInt32(questions.count)))].answer
            let answerOption3 = questions[Int(arc4random_uniform(UInt32(questions.count)))].answer
            let answerOption4 =  questions[Int(arc4random_uniform(UInt32(questions.count)))].answer
        
            // define an array with questions
            var answers = [answerOption1, answerOption2, answerOption3, answerOption4]
        
            // scrammble answer order
            answers.shuffle()
            
            self.currentAnswers = answers

            // update question label with question and buttons with answers
            self.questionLabel.text = String(currentQuestion)
            self.answerButton1.setTitle(answers[0], for: .normal)
            self.answerButton2.setTitle(answers[1], for: .normal)
            self.answerButton3.setTitle(answers[2], for: .normal)
            self.answerButton4.setTitle(answers[3], for: .normal)
        }
        
    }
    

    // go to next next question until the 25th is reached
    func nextQuestion() {
        questionIndex += 1
        totalTime = 15
        if questionIndex < 25 {
            updateUI(with: questions)
        // when 25th question is reached, present score and move on to highscores
        } else {
            let alert = UIAlertController(title: "submit", message: "Your score is \(correctAnswers), submit now!)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in
                self.performSegue(withIdentifier: "ResultsSegue", sender: nil)}
            )
            present(alert, animated: true, completion: nil)
        }
            
        
    }
    
    /// if button is pressed increment correctanswer if correct button is pressed and animate button
    @IBAction func answerButtonPressed(_sender: UIButton) {
        

        
        
        switch _sender {
        case answerButton1:
            if currentAnswers[0] == currentAnswer {
                correctAnswers += 1
            }
            UIView.animate(withDuration: 0.2) {
                self.answerButton1.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.answerButton1.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        case answerButton2:
            if currentAnswers[1] == currentAnswer {
                correctAnswers += 1
            }
            UIView.animate(withDuration: 0.2) {
                self.answerButton2.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.answerButton2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        case answerButton3:
            if currentAnswers[2] == currentAnswer {
                correctAnswers += 1
            }
            UIView.animate(withDuration: 0.2) {
                self.answerButton3.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.answerButton3.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        case answerButton4:
            if currentAnswers[3] == currentAnswer {
                correctAnswers += 1
            }
            UIView.animate(withDuration: 0.2) {
                self.answerButton4.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.answerButton4.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        default:
            print(":)")
        }
        print(correctAnswers)
        
        // move on to next question
        nextQuestion()
    }
    
    // prepare to go to the results
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsTableViewController = segue.destination as! ResultsTableViewController
            resultsTableViewController.answers = correctAnswers
        }
    }
    
    /// start timer
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    /// decrement time until it reaches 0, then move on to next question
    @objc func updateTime() {
        timer.text = "\(totalTime)"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            nextQuestion()
        }
    }
    
}
