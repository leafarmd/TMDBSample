//
//  API.swift
//  TMDBSample
//
//  Created by Rafael Damasceno on 01/08/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit
import Foundation

class API: APICore {
    
    private let apiKey = "b37e68f5dd8b87632816b12d304d2855"
    
    func requestObject<T>(from endpoint: APIRequest, type: T.Type, completion: @escaping  CompletionCallback<T>) where T : Output {
        
        request(from: endpoint.url,
                params: endpoint.params,
                type: type,
                method: endpoint.method,
                completion: completion)
        
    }
    
    private func request<T: Decodable>(from endpoint: String,
                                       params: [String: String],
                                       type: T.Type,
                                       method: HttpMethod,
                                       completion: @escaping CompletionCallback<T>) {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let pathURL = endpoint
        
        var baseURL = URLComponents(string: pathURL)
        baseURL?.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        params.forEach { baseURL?.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) }
        
        guard let url = baseURL?.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        var request : URLRequest = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let dataType = try decoder.decode(type.self, from: data)
                    completion(.success(dataType))
                } catch {
                    do {
                        let errorType = try decoder.decode(APIError.self, from: data)
                        completion(.error(errorType))
                    } catch {
                        completion(.failure(.decodingFailed))
                    }
                }
            }
            }.resume()
    }
    
    func requestImage(from request: APIRequest, size: APIRequest.ImageSize,  completion: @escaping RequestImageResult) {
        
        guard let url = URL(string: request.url) else {
            completion(.failure(.invalidData))
            return
        }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } catch {
                completion(.failure(.invalidData))
            }
        }
    }
}

