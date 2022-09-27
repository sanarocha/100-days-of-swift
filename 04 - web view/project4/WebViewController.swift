//
//  ViewController.swift
//  project4
//
//  Created by PremierSoft on 30/12/21.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    
    private lazy var webView = WebView(delegate: self, websites: self.viewModel.websites)
    private var progressView: UIProgressView?
    private let viewModel = WebViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadUrl(with: "https://www.hackingwithswift.com")
    }
    
    override func loadView() {
        self.view = webView
        self.title = "Web View"
        setRightBarButton()
        addToolbar()
    }
    
    private func setupLayout() {
        webView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - Web View Navigation Delegate
extension WebViewController: WKNavigationDelegate {
    
}

//MARK: - Navigation Bar
extension WebViewController {
    
    private func setRightBarButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(openTapped))
        self.navigationController?.navigationBar.backgroundColor = .white
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        for website in self.viewModel.websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + self.viewModel.websites[0])
        if let url = url {
            self.webView.load(URLRequest(url: url))
        }
    }
}

//MARK: - Toolbar

extension WebViewController {
    
    private func addToolbar() {
        self.progressView = UIProgressView(progressViewStyle: .default)
        progressView?.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView ?? UIProgressView())
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: webView,
                                      action: #selector(self.webView.reload))

        toolbarItems = [progressButton, spacer, refresh]
        self.navigationController?.isToolbarHidden = false
        
        self.webView.addObserver(self,
                                 forKeyPath:  #keyPath(WKWebView.estimatedProgress),
                                 options: .new,
                                 context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView?.progress = Float(webView.estimatedProgress)
        }
    }
}

