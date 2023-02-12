//
//  WebViewController.swift
//  EasyNews
//
//  Created by Ye Ma on 12/02/2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    var url: URL?
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        
        webView.uiDelegate = self

        return webView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        loadURL()
    }
    
    private func loadURL() {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
