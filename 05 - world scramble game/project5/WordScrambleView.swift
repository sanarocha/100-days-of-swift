//
//  WordScrambleView.swift
//  project5
//
//  Created by Rossana Rocha on 08/01/22.
//

import UIKit
import SnapKit

class WordScrambleView: UIView {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var usedWords = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    init() {
        super.init(frame: .zero)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Actions
extension WordScrambleView {
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func usedWordsChanged(to newUsedWords: [String]) {
        self.usedWords = newUsedWords
    }
}

//MARK: - Layout
extension WordScrambleView {
    
    private func setupLayout() {
        self.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Word")
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: - Table View Delegate

extension WordScrambleView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.usedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

