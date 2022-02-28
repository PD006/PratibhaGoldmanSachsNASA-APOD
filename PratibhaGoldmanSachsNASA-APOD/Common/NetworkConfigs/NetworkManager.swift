//
//  NetworkManager.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 26/02/22.
//
import Foundation

protocol NetworkManagerProtocol {
    func startRequest(request: APIRequestData, basePath: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    
    private init() {
    }
    
    func startRequest(request: APIRequestData, basePath: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        do {
            let urlRequest = try self.createURLRequest(apiRequestData: request, basePath: basePath)
            
            task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            task?.resume()
        } catch {
            completion(nil, nil, error)
        }
    }
}

private extension NetworkManager {
    
    private func createURLRequest(apiRequestData: APIRequestData, basePath: String) throws -> URLRequest {
        do {
            if let url = URL(string: apiRequestData.absolutePath(from: basePath))  {
                
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = apiRequestData.method.rawValue
                self.addRequestHeaders(request: &urlRequest, requestHeaders: apiRequestData.headers)
                try self.encode(request: &urlRequest, parameters: apiRequestData.parameters)
                
                return urlRequest
            } else {
                throw NetworkError.malformedURL
            }
        } catch {
            throw error
        }
    }
    
    private func addRequestHeaders(request: inout URLRequest, requestHeaders: [String: String]?){
        guard let headers = requestHeaders else{
            return
        }
        for (key, value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func encode(request: inout URLRequest, parameters: RequestParams?) throws{
        
        guard let url: URL = request.url else {
            throw NetworkError.malformedURL
        }
        guard let parameters = parameters else{
            return
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let urlParams = parameters.urlParameters, !urlParams.isEmpty{
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in urlParams{
                let queryItem = URLQueryItem(name: key, value: value)
                urlComponents.queryItems?.append(queryItem)
            }
            request.url = urlComponents.url
        }
    }
    
    private func encodeJSON(request: inout URLRequest, parameters: [String: Any]) throws{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
            request.setValue(HeaderContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderKeys.contentType.rawValue)
            
        }catch{
            throw NetworkError.parameterEncodingFailed
        }
    }
}
