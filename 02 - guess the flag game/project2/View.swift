//
//  View.swift
//  project2
//
//  Created by PremierSoft on 27/12/21.
//

import UIKit
import SnapKit

protocol ViewDelegate {
    func answerIsCorrect()
    func answerIsWrong()
}

class View: UIView {

    private let flag1: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = .init(red: 170/255.0,
                                         green: 170/255.0,
                                         blue: 170/255.0,
                                         alpha: 1)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    private let flag2: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = .init(red: 170/255.0,
                                         green: 170/255.0,
                                         blue: 170/255.0,
                                         alpha: 1)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    private let flag3: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = .init(red: 170/255.0,
                                         green: 170/255.0,
                                         blue: 170/255.0,
                                         alpha: 1)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    private var answerText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 21)
        label.textAlignment = .center
        return label
    }()
    private var countries: [String]
    private var correctAnswer = 0
    private let delegate: ViewDelegate
    
    init(countries: [String], delegate: ViewDelegate) {
        self.countries = countries
        self.delegate = delegate
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout

extension View {

    private func setupLayout(){
        addButtons()
        addLabel()
        askQuestion()
        self.backgroundColor = .systemGray6
    }
    
    private func addButtons(){
        self.addSubview(flag1)
        self.addSubview(flag2)
        self.addSubview(flag3)
        
        flag1.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        flag2.snp.makeConstraints { make in
            make.top.equalTo(flag1.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        flag3.snp.makeConstraints { make in
            make.top.equalTo(flag2.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addLabel(){
        self.addSubview(answerText)
        
        answerText.snp.makeConstraints { make in
            make.top.equalTo(flag3.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        correctAnswer = Int.random(in: 0...2)
        self.answerText.text = "Choose the correct flag of the country '\(countries[correctAnswer].uppercased())'"
        flag1.setImage(UIImage(named: countries[0]), for: .normal)
        flag2.setImage(UIImage(named: countries[1]), for: .normal)
        flag3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
}

//MARK: - Actions
extension View {
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            self.answerText.text = "Correct!"
            self.delegate.answerIsCorrect()
        } else {
            self.answerText.text = "Wrong, try again"
            self.delegate.answerIsWrong()
        }
    }
    
    func reloadCountries(countries: [String]) {
        self.countries = countries
    }
}
