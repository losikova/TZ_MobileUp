//
//  Service.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/27/22.
//

import UIKit
import SwiftKeychainWrapper

class Service {
    
    func getPhotos(completion: @escaping ([Photo]) -> Void, errorCompletion: @escaping (String) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token",
                         value: KeychainWrapper.standard.string(forKey: StringKeys.accessToken.rawValue)),
            URLQueryItem(name: "owner_id", value: "-128666765"),
            URLQueryItem(name: "album_id", value: "266276915"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let photos = try JSONDecoder().decode(PhotoResponse.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch {
                self.errorService(description: error.localizedDescription, completion: errorCompletion)
            }
        }
        urlSession.resume()
    }
    
    func errorService(description: String, completion: @escaping (String) -> ()) {
        DispatchQueue.main.async {
            completion(description)
        }
    }
}
