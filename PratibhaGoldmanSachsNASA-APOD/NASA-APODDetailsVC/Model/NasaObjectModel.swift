//
//  NasaObjectModel.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 26/02/22.
//

import Foundation

struct NasaObjectModel {
    let date: String?
    let explanation: String?
    let media_type: MediaType?
    let title: String
    let mediaURL: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case title
        case media_type = "media_type"
        case mediaURL = "url"
    }
}

extension NasaObjectModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decode(String.self, forKey: .date)
        explanation = try container.decode(String.self, forKey: .explanation)
        title = try container.decode(String.self, forKey: .title)
        mediaURL = try container.decode(String.self, forKey: .mediaURL)
        media_type = try container.decode(MediaType.self, forKey: .media_type)
    }
}

enum MediaType: String, Decodable {
    case image
    case video
    case other
    
    init(from decoder: Decoder) throws {
        
        let mediaValue = try decoder.singleValueContainer().decode(String.self)
        switch mediaValue {
        case "image": self = .image
        case "video": self = .video
        default: self = .other
        }
    }
}
