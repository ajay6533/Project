//
//  detailViewController.swift
//  project7
//
//  Created by Ajay Kumar on 06/11/19.
//  Copyright © 2019 GameNexas. All rights reserved.
//

import UIKit
import WebKit

class detailViewController: UIViewController {
    var webview : WKWebView!
    var detailItem : Petition?

    override func loadView() {
        webview = WKWebView()
        view = webview
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webview.loadHTMLString(html, baseURL: nil)
    }

}
