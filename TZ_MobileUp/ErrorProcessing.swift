//
//  ErrorProcessing.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/29/22.
//

import UIKit

enum ApplicationErrors: String {
    case dataError = "Ошибка загрузки данных"
    case requestError = "Ошибка запроса из сети"
    case responseError = "Некорректный ответ сервера"
    case photoSaveError = "Ошибка сохранения фотографии"
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
