//
//  LoadingView.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/29/22.
//

import UIKit

class LoadingView: UIView {
    
    enum Animate {
        case start
        case stop
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        let dot2 = UIView()
        self.addSubview(dot2)
        dot2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dot2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dot2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dot2.widthAnchor.constraint(equalToConstant: 20),
            dot2.heightAnchor.constraint(equalToConstant: 20)
        ])
        dot2.clipsToBounds = true
        dot2.backgroundColor = .black
        dot2.layoutIfNeeded()
        dot2.layer.cornerRadius = dot2.bounds.height / 2
        
        let dot1 = UIView()
        self.addSubview(dot1)
        dot1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dot1.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30),
            dot1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dot1.widthAnchor.constraint(equalToConstant: 20),
            dot1.heightAnchor.constraint(equalToConstant: 20)
        ])
        dot1.clipsToBounds = true
        dot1.backgroundColor = .black
        dot1.layoutIfNeeded()
        dot1.layer.cornerRadius = dot1.bounds.height / 2
        
        let dot3 = UIView()
        self.addSubview(dot3)
        dot3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dot3.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 30),
            dot3.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dot3.widthAnchor.constraint(equalToConstant: 20),
            dot3.heightAnchor.constraint(equalToConstant: 20)
        ])
        dot3.clipsToBounds = true
        dot3.backgroundColor = .black
        dot3.layoutIfNeeded()
        dot3.layer.cornerRadius = dot3.bounds.height / 2
        
        self.isHidden = true
    }
    
    func animateLoading(_ animate: Animate) {
        self.isHidden = false
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.1
        animation.toValue = 1
        animation.duration = 0.3
        animation.repeatDuration = .infinity
        animation.autoreverses = true
        
        switch animate {
        case .start:
            self.isHidden = false
            self.subviews[1].layer.add(animation, forKey: nil)
            animation.beginTime = CACurrentMediaTime() + 0.1
            self.subviews[0].layer.add(animation, forKey: nil)
            animation.beginTime = CACurrentMediaTime() + 0.2
            self.subviews[2].layer.add(animation, forKey: nil)
        case .stop:
            self.subviews[1].layer.removeAllAnimations()
            self.subviews[0].layer.removeAllAnimations()
            self.subviews[2].layer.removeAllAnimations()
            self.isHidden = true
        }
    }

}

