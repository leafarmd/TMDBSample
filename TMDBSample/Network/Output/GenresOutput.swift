//
//  GenresOutput.swift
//  TMDBSample
//
//  Created by Rafael Damasceno on 01/08/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation

struct GenresOutput: Output {
    let genres: [GenreOutput]
    
    static func mock() -> GenresOutput {
        return GenresOutput(genres: [GenreOutput.mock()])
    }

}
struct GenreOutput: Output {
    let id: Int
    let name: String
    
    static func mock() -> GenreOutput {
        return GenreOutput(id: 1, name: "genre name")
    }
}
