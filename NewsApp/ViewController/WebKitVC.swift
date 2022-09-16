//
//  WebKitVC.swift
//  NewsApp
//
//  Created by Berkay on 16.09.2022.
//

import UIKit
import WebKit

class WebKitVC: UIViewController {


    @IBOutlet weak var webView: WKWebView!
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if url != nil {
            let myURL = URL(string: url!)
            webView.load(URLRequest(url: myURL!))
            webView.allowsBackForwardNavigationGestures = true
        }
    }

}
