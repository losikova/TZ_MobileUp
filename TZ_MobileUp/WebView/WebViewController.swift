//
//  WebViewController.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/26/22.
//

import UIKit
import WebKit

protocol WebViewControllerClosedProtocol: AnyObject {
    func webViewDidDisapper(withAuth: Bool)
}

class WebViewController: UIViewController {
    
    /// - parameter delegate: Delegate for closing popover
    var delegate: WebViewControllerClosedProtocol?
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isModalInPresentation = true
        setupUI()
        setupWeb()
    }
    
    var isAuthorized = false
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.delegate?.webViewDidDisapper(withAuth: isAuthorized)
    }

    private func setupUI() {
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        webView.clipsToBounds = true
    }
    
    private func setupWeb() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8089981"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "wall"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else {
            //error
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        let alert = UIAlertController(title: "", message: "Хотите выйти из авторизации через VK?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default) { _ in
            self.dismiss(animated: true)
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive))
        self.present(alert, animated: true)
    }
}
