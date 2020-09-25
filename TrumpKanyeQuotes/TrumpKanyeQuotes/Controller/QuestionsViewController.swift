//
//  QuestionsViewController.swift
//  TrumpElonTweets
//
//  Created by apple on 2020/9/21.
//

import UIKit


//MARK: - Main Section
class QuestionsViewController: UIViewController {
    //create IBOutlets
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!
    @IBOutlet weak var trumpButton: UIButton!
    @IBOutlet weak var kanyeButton: UIButton!
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    //initialize variables
    var currentQuestionNum = 0
    var currentChoice = ""
    var currentScore = 0
    var currentAnswer = ""
    var quoteManager = QuoteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteManager.delegate = self
        questionText.text = "Loading Quote..."
        self.quoteManager.fetchQuote()
    }
    
    // will execute when either the "Trump" or "Kanye" button is pressed
    @IBAction func choiceButtonPressed(_ sender: UIButton) {
        currentChoice = sender.currentTitle!
        sender.backgroundColor = K.Color.changedColor
        if sender.currentTitle == "Trump"{
            kanyeButton.backgroundColor = K.Color.originalColor
        }else{
            trumpButton.backgroundColor = K.Color.originalColor
        }
    }
    
    // will execute when "Next Question" button is pressed
    @IBAction func nextQuestionButtonPressed(_ sender: UIButton) {
        questionText.text = "Loading Quote..."
        checkAnswer() // check whether the user's choice is correct and update score
        updateQuestionNum() // update question number
        self.quoteManager.fetchQuote()
    }
    
    // checks whether the user's choice is correct and update score
    func checkAnswer(){
        currentChoice == currentAnswer ? currentScore += 1: nil
        currentScoreLabel.text = "Current Score: " + String(currentScore)
    }
    
    // updates question number
    func updateQuestionNum(){
        currentQuestionNum < K.numQuestions - 1 ? currentQuestionNum += 1 : performSegue(withIdentifier: K.Segue.questionToResult, sender: self)
    }
    
}
//MARK: - Segue Section

// jump to result page when 10 questions are reached
extension QuestionsViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ResultViewController{
            let vc = segue.destination as? ResultViewController
            vc?.score = currentScore
        }
    }
}

//MARK: - QuoteManagerDelegate

// updates the quotes
extension QuestionsViewController: QuoteManagerDelegate{
    func updateQuote(_ quoteManager: QuoteManager, quote: QuoteModel){
        DispatchQueue.main.async {
            self.kanyeButton.backgroundColor = K.Color.originalColor
            self.trumpButton.backgroundColor = K.Color.originalColor
            self.questionProgressView.progress = Float(self.currentQuestionNum) / Float(K.numQuestions)
            self.questionText.text = quote.question
            self.currentAnswer = quote.answer
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

