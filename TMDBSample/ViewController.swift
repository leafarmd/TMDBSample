//
//  ViewController.swift
//  TMDBSample
//
//  Created by Rafael Damasceno on 01/08/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = API()
        
        api.requestObject(from: .genre, type: GenresOutput.self) { result in
            switch result {
            case .success(let genres):
                print(genres)
            case .failure(let failure):
                print(failure)
            case .error(let error):
                print(error)
            }
        }
        
        let apiStub = APIStub(status: .failure(RequestError.invalidData))
        
        
        apiStub.requestObject(from: .genre, type: GenresOutput.self) { result in
            switch result {
            case .success(let genres):
                print(genres)
            case .failure(let failure):
                print(failure)
            case .error(let error):
                print(error)
            }
            
        }
    }
}

