//
//  ViewController.swift
//  project2
//
//  Created by PremierSoft on 27/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var flagsView = View(countries: self.viewModel.countries, delegate: self)
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
    }
    
    override func loadView() {
        self.view = flagsView
        self.title = "Score: \(self.viewModel.score)"
    }
}

//MARK: - Alerts
extension ViewController {
    
    private func showContinueAlertWith(title: String) {
        let ac = UIAlertController(title: title,
                                   message: "Your score is \(self.viewModel.score)",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue",
                                   style: .default,
                                   handler: self.flagsView.askQuestion(action:)))
        self.present(ac, animated: true)
    }
    
    private func showFinalScore(){
        let ac = UIAlertController(title: "Game Over",
                                   message: "Your final score is \(self.viewModel.score)",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Play again",
                                   style: .default,
                                   handler: self.flagsView.askQuestion(action:)))
        self.present(ac, animated: true)
    }
}

//MARK: - View Delegate
extension ViewController: ViewDelegate {
    func answerIsWrong() {
        self.viewModel.decreaseScore()
        showContinueAlertWith(title: "Wrong!")
    }
    
    func answerIsCorrect() {
        self.viewModel.raiseScore()
        showContinueAlertWith(title: "Correct!")
    }
}

//MARK: - View Model Delegate
extension ViewController: ViewModelDelegate {
    func maxNumberOfPlaysReached() {
        showFinalScore()
        self.viewModel.resetScore()
    }
    
    func scoreDidChange(to newScore: Int) {
        self.title = "Score: \(self.viewModel.score)"
    }
    
    func countriesDidChange(countries: [String]) {
        self.flagsView.reloadCountries(countries: self.viewModel.countries)
    }
}

