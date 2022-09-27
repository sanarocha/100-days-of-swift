//
//  ViewController.swift
//  project1
//
//  Created by Rossana Rocha on 22/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    private func findPicturesToLoad() {
        let file = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! file.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
            }
        }
    }


}

