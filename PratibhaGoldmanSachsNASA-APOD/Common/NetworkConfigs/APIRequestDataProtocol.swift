//
//  APIDataProtocol.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 26/02/22.
//

import Foundation

protocol APIRequestData {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: [String: String]? { get }
    var dataType: ResponseDataType { get }
    func absolutePath(from basePath: String) -> String
}

extension APIRequestData {
    func absolutePath(from basePath: String) -> String {
        return basePath + path
    }
}
