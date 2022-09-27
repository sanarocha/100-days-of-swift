//
//  WordScrambleViewModel.swift
//  project5
//
//  Created by Rossana Rocha on 08/01/22.
//

import Foundation
import UIKit

protocol WordScrambleViewModelDelegate {
    func startGame(with randomWord: String)
    func usedWordsChanged(to newUsedWords: [String])
    func showErrorMessage(title: String, message: String)
}

class WordScrambleViewModel {
    
    private var allWords = [String]()
    private var usedWords = [String]() {
        didSet {
            self.delegate?.usedWordsChanged(to: self.usedWords)
        }
    }
    private var startWord = String()
    private var delegate: WordScrambleViewModelDelegate?
    
    init() {
        self.getWordsFromTxt()
    }
    
    func setDelegate(_ delegate: WordScrambleViewModelDelegate) {
        self.delegate = delegate
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if self.startWord == answer {
            self.delegate?.showErrorMessage(title: "Words are the same",
                                            message: "You can't use the same word as the start one")
            return
        }

        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    self.usedWords.insert(lowerAnswer, at: 0)
                return
            } else {
                self.delegate?.showErrorMessage(title: "Word not recognised",
                                                message: "You can't just make them up, you know!")
             }
            } else {
                self.delegate?.showErrorMessage(title: "Word used already",
                                                message: "Be more original!")
             }
            } else {
                self.delegate?.showErrorMessage(title: "Word not possible",
                                                message: "You can't spell that word from the top one!")
            }
    }
    
    private func isPossible(word: String) -> Bool {
        
        for letter in word {
            if let position = startWord.firstIndex(of: letter) {
                startWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }

    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        if word.utf16.count < 3 {
            return false
        }
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    private func getWordsFromTxt() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                self.allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
    }

    func startNewGame() {
        let randomWord = self.allWords.randomElement()
        self.delegate?.startGame(with: randomWord ?? "")
        self.startWord = randomWord ?? ""
        self.usedWords.removeAll(keepingCapacity: true)
    }
}
