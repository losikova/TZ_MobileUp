//
//  PhotoService.swift
//  TZ_MobileUp
//
//  Created by Анастасия Лосикова on 3/27/22.
//

import Foundation

class PhotoResponse: Decodable {
    let response: PhotoItem
}

class PhotoItem: Decodable {
    let items: [Photo]
}

class Photo: Decodable {
    var id = 0
    var ownerId = 0
    var url = ""
    var date = 0
    var sizes: [Size]
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case url
        case date
        case sizes
    }
    
    required init(from decoder: Decoder) throws {
        let item = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try item.decode(Int.self, forKey: .id)
        self.ownerId = try item.decode(Int.self, forKey: .ownerId)
        self.date = try item.decode(Int.self, forKey: .date)
        self.sizes = try item.decode([Size].self, forKey: .sizes)
    }
    
    class Size: Codable {
        var url = ""
        var type = ""
    }
}
