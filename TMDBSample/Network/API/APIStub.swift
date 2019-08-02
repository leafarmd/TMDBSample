//
//  APIStub.swift
//  TMDBSample
//
//  Created by Rafael Damasceno on 01/08/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation
import UIKit

class APIStub: APICore {
    func requestImage<T>(from request: APIRequest, size: APIRequest.ImageSize, completion: @escaping (Result<T, RequestError>) -> Void) where T : UIImage {
     
    }
    
    
    
    
    var url: String?
    var method: HttpMethod?
    var params: [String: String]?
    
    let status: CompletionStatus<Output>
    
    init(status: CompletionStatus<Output>) {
        self.status = status
    }
    
    func requestObject<T>(from endpoint: APIRequest, type: T.Type, completion: @escaping CompletionCallback<T>) where T : Output {
        
        url = endpoint.url
        method = endpoint.method
        params = endpoint.params
    
        switch status {
        case .success(let result):
            completion(.success(result as! T))
        case .failure(let failure):
            completion(.failure(failure))
        case .error(let error):
            completion(.error(error))
        }
    }
    
}
