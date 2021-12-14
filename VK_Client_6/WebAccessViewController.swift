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
        initialRequest()
        
    }
    
    func initialRequest() {
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
            print("MARK_1_URLResponse")
            let urlResponse = navigationResponse.response.url
            print(urlResponse)
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
        print("MARK_2_TOKEN")
        print(token)
        print("MARK_3_USER_ID")
        print(userId)
        Session.shared.token = token
        Session.shared.userID = userId
        getFriends()
        getPhoto()
        getGroups()
        getGroupsSearch()
        decisionHandler(.cancel)
    }
    func getFriends() {
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            URLQueryItem(name: "fields", value: "city"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        print("MARK_4_FRIENDS_REQUEST")
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print("MARK_5_FRIENDS_RESPONSE")
            print(json)
        }
        task.resume()
    }
    func getPhoto() {
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            //URLQueryItem(name: "fields", value: "city"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        print("MARK_6_PHOTO_REQUEST")
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print("MARK_7_PHOTO_RESPONSE")
            print(json)
        }
        task.resume()
    }
    
    func getGroups() {
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "extended"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        print("MARK_8_GROUPS_REQUEST")
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print("MARK_9_GROUPS_RESPONSE")
            print(json)
        }
        task.resume()
    }
    
    func getGroupsSearch() {
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            URLQueryItem(name: "q", value: "music"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        print("MARK_10_GROUPS_SEARCH_REQUEST")
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print("MARK_11_GROUPS_SEARCH_RESPONSE")
            print(json)
        }
        task.resume()
    }

  

}
