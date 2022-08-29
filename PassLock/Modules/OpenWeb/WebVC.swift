//
//  WebVC.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 24/08/22.
//

import UIKit
import WebKit

class WebVC: BaseVC {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    var webLink = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0
        loadWebPage()
    }
    func loadWebPage() {
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: self.webLink)!
            let urlRequest = URLRequest(url: url)
            DispatchQueue.main.async {
                self.webView.load(urlRequest)
                self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
            }
        }
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print("estimatedProgress")
            progressBar.progress = Float(webView.estimatedProgress)
            if progressBar.progress >= 1.0 {
                progressBar.isHidden = true
            }
        }
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        backTapped()
    }
}
