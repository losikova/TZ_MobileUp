//
//  LoginViewController.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/25/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    /// - parameter LoginView: Main View in Login Controller
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loginView.clipsToBounds = true
        loginView.backgroundColor = .white
    }
}

extension LoginViewController: OpenWebViewProtocol {
    func openWebView(_ controller: WebViewController) {
        let controller = WebViewController()
        controller.modalPresentationStyle = .popover
        controller.presentationController?.delegate = controller
        
        present(controller, animated: true)
    }
}

