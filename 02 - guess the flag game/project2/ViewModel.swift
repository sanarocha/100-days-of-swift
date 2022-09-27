//
//  ViewModel.swift
//  project2
//
//  Created by PremierSoft on 27/12/21.
//

import Foundation
import UIKit

protocol ViewModelDelegate {
    func countriesDidChange(countries: [String])
    func scoreDidChange(to newScore: Int)
    func maxNumberOfPlaysReached()
}

class ViewModel {
    
    var countries = [String]() {
        didSet {
            self.delegate?.countriesDidChange(countries: self.countries)
        }
    }
    var delegate: ViewModelDelegate?
    var score = 0 {
        didSet {
            self.delegate?.scoreDidChange(to: self.score)
        }
    }
    
    var plays = 0 {
        didSet {
            if plays == 10 {
                self.delegate?.maxNumberOfPlaysReached()
                plays = 0
            }
        }
    }
    
    init(){
        addCountries()
    }
    
    private func addCountries(){
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    func raiseScore(){
        self.score += 1
        plays += 1
        countries.shuffle()
    }
    
    func decreaseScore(){
        self.score -= 1
        plays += 1
        countries.shuffle()
    }
    
    func resetScore(){
        self.score = 0 
    }
    
}
