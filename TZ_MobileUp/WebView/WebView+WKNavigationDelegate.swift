//
//  WebView+WKNavigationDelegate.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/26/22.
//

import UIKit
import WebKit
import SwiftKeychainWrapper

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"] else { return }
        
        KeychainWrapper.standard.set(token, forKey: StringKeys.accessToken.rawValue)
    
        decisionHandler(.cancel)
//        
//        let tabBarController = TabBarViewController()
//        tabBarController.modalPresentationStyle = .fullScreen
//        present(tabBarController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let message: String = error.localizedDescription
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) {[weak self] action in
            self?.dismiss(animated: true)
        })
        self.present(alert, animated: true)
    }
}
