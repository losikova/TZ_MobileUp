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
        controller.delegate = self
        
        present(controller, animated: true)
    }
}

extension LoginViewController: WebViewControllerClosedProtocol {
    func webViewDidDisapper(withAuth: Bool) {
        if withAuth {
            openGallery()
        } else {
            presentAlert()
        }
    }
    
    func openGallery() {
        let navigationController = UINavigationController(rootViewController: GalleryViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Warning", message: "Вы вышли из авторизации VK", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

