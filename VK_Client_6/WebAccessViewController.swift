//
//  WebAccessViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 14.12.2021.
//

import UIKit
import WebKit

class WebAccessViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var urlComponents = URLComponents()
    let session = URLSession.shared
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7833687"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        print(request)
        
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
           // let urlResponse = navigationResponse.response.url
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"], let userId = params["user_id"] else { return }
        Session.shared.token = token
        Session.shared.userID = userId
        performSegue(withIdentifier: "segue", sender: nil)
        decisionHandler(.cancel)
        
    }
    
}
