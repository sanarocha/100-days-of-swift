//
//  WebView.swift
//  project4
//
//  Created by PremierSoft on 30/12/21.
//

import UIKit
import WebKit
import SnapKit

class WebView: WKWebView {
    
    private let config = WKWebViewConfiguration()
    private let delegate: WKNavigationDelegate?
    private let websites: [String]
    
    init(delegate: WKNavigationDelegate, websites: [String]) {
        self.websites = websites
        self.delegate = delegate
        super.init(frame: .zero, configuration: self.config)
        self.allowsBackForwardNavigationGestures = true
    }
    
    public func loadUrl(with urlToLoad: String) {
        let url = URL(string: urlToLoad)
        if let url = url {
            self.load(URLRequest(url: url))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

            if let host = url?.host {
                for website in websites {
                    if host.contains(website) {
                        decisionHandler(.allow)
                        return
                    }
                }
            }

            decisionHandler(.cancel)
    }
}
