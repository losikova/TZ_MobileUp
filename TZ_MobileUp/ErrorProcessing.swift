//
//  ErrorProcessing.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/29/22.
//

import UIKit

enum ApplicationErrors: String {
    case dataError = "Data loading error"
    case requestError = "Network request failed"
    case responseError = "Incorrect server response"
    case photoSaveError = "Photo saving error"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

extension UIViewController {
    
    func errorAlert(type: ApplicationErrors) {
        let alert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
    
    func errorAlertWithDescription(_ description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}
