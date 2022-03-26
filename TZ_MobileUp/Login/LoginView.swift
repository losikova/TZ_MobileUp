//
//  LoginView.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/26/22.
//

import UIKit

protocol OpenWebViewProtocol: AnyObject {
    func openWebView(_ controller: WebViewController)
}

class LoginView: UIView {
    
    /// - parameter label: Mobile Up Gallary Label
    private let label = UILabel()
    
    /// - parameter buttonView: Login Button View
    private let buttonView = UIView()
    
    /// - parameter loginButton: Login Button
    private let loginButton = UIButton()
    
    /// - parameter buttonTitle: Login Button Title
    private let buttonTitle = UILabel()
    
    /// - parameter delegate: Delegate for Login Button
    var delegate: OpenWebViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        
        /// Mobile Up Label
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 327),
        // FIXME: Высота 114 не влезает со шрифтом 48
            label.heightAnchor.constraint(equalToConstant: 115),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 164),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24)
        ])
        label.text = "Mobile Up\nGallery"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 48)
        label.textColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        /// Login Button View
        addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.clipsToBounds = true
        NSLayoutConstraint.activate([
            buttonView.leftAnchor.constraint(equalTo: self.leftAnchor),
            buttonView.rightAnchor.constraint(equalTo: self.rightAnchor),
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -34),
            buttonView.heightAnchor.constraint(equalToConstant: 88)
        ])
        
        /// Login Button
        buttonView.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.clipsToBounds = true
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            loginButton.widthAnchor.constraint(equalToConstant: 327)
        ])
        loginButton.layer.cornerRadius = 8
        loginButton.layer.backgroundColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1).cgColor
        loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        
        /// Login Button Title
        loginButton.addSubview(buttonTitle)
        buttonTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonTitle.clipsToBounds = true
        NSLayoutConstraint.activate([
            buttonTitle.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            buttonTitle.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
        ])
        buttonTitle.text = "Вход через VK"
        buttonTitle.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        buttonTitle.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        buttonTitle.textAlignment = .center
    }
    
    /// - parameter loginButtonPressed: Open Web View
    @objc func loginButtonPressed(_ sender: UIButton) {
        let webViewViewController = WebViewController()
        self.delegate?.openWebView(webViewViewController)
    }
    
}
