//
//  ViewController.swift
//  project5
//
//  Created by Rossana Rocha on 08/01/22.
//

import UIKit

class WordScrambleViewController: UIViewController {
    
    private lazy var wordScrambleView = WordScrambleView()
    private let viewModel = WordScrambleViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewModel.setDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarButtons()
        self.viewModel.startNewGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view = wordScrambleView
    }
}

//MARK: - View Model Delegate
extension WordScrambleViewController: WordScrambleViewModelDelegate {
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func usedWordsChanged(to newUsedWords: [String]) {
        self.wordScrambleView.usedWordsChanged(to: newUsedWords)
    }
    
    func startGame(with randomWord: String) {
        self.title = randomWord
        self.wordScrambleView.reloadTableView()
    }
}

//MARK: - Navigation Bar
extension WordScrambleViewController {
    
    private func setupNavigationBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play,
                                                           target: self,
                                                           action: #selector(startGameFromButton))
    }
    
    @objc func startGameFromButton() {
        self.viewModel.startNewGame()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.viewModel.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

