//
//  APICore.swift
//  TMDBSample
//
//  Created by Rafael Damasceno on 01/08/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation
import UIKit

typealias Output = Decodable & Mockable

protocol Mockable {
    static func mock() -> Self
}

protocol APICore: class {
    func requestObject<T: Output>(from request: APIRequest, type: T.Type, completion: @escaping CompletionCallback<T>)
    func requestImage(from request: APIRequest, size: APIRequest.ImageSize,  completion: @escaping RequestImageResult)
}

enum CompletionStatus<T> {
    case success(T)
    case failure(RequestError)
    case error(APIError)
}

enum RequestError: Error {
    case malformedURL
    case requestFailed
    case invalidData
    case decodingFailed
    
    var message: String {
        switch self {
        case .malformedURL:
            return "error with URL requested"
        case .requestFailed:
            return "error with request"
        case .invalidData:
            return "invalid data"
        case .decodingFailed:
            return "data decode failed"
        }
    }
}

enum HttpMethod: String {
    case POST
    case GET
}

struct APIError: Decodable {
    let message: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "status_message"
        case code = "status_code"
    }
}


typealias RequestResult<T> = Result<T, RequestError>
typealias RequestImageResult = (Result<UIImage, RequestError>) -> Void
typealias CompletionCallback<T: Decodable> = (CompletionStatus<T>) -> Void

