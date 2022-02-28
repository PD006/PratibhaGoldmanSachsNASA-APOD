//
//  NetworkConfig.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 26/02/22.
//

import Foundation

enum HTTPMethod: String {
    case get
}

enum HeaderContentType: String {
    case json = "application/json"
}

enum HTTPHeaderKeys: String {
    case contentType = "Content-Type"
    case cookie = "Cookie"
}

enum ResponseDataType {
    case Data
    case JSON
}

struct RequestParams {
    let urlParameters: [String: String]?
    let contentType: HeaderContentType
    
    init(urlParameters: [String: String]?, contentType: HeaderContentType = .json) {
        self.urlParameters = urlParameters
        self.contentType = contentType
    }
}
