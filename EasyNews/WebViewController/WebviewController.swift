//
//  WebviewController.swift
//  EasyNews
//
//  Created by Ye Ma on 12/02/2023.
//

import UIKit
import WebKit

class WebviewController: UIViewController, WKUIDelegate {
    
    var url: URL? {
        didSet {
            guard let url = url else { return }
            
            let myRequest = URLRequest(url: url)
            self.webView.load(myRequest)
        }
    }
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        view.addSubview(webView)
        
        webView.uiDelegate = self
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return webView
    } ()
}
