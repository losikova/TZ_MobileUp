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
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let fragment = webView.url?.fragment {
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
            
            guard let token = params["access_token"]
//                  let userID = params["user_id"]
//                  let expireDate = Double(params["expires_in"] ?? "")
            else {
                //error
                return
            }
            
            print(token)
            
            KeychainWrapper.standard.set(token, forKey: StringKeys.accessToken.rawValue)

//            let userInfo = UserInfo()
//            userInfo.id = userID
//            userInfo.tokenExpire = Date().timeIntervalSince1970 + expireDate
//            print(userInfo)
//
            UserDefaults.standard.set(true, forKey: StringKeys.isAuthorized.rawValue)
            
            let navigationController = UINavigationController(rootViewController: GalleryViewController())
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false, completion: nil)
        }

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
