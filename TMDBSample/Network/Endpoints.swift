//
//  Endpoints.swift
//  TMDBSample
//
//  Created by Rafael Damasceno on 01/08/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation

enum APIRequest {
    case upcoming(language: String, page: Int)
    case genre
    case movieDetail(_ id: Int, language: Language)
    case searchMovie(query: String, language: String, page: Int)
    case image(url: String)
}

extension APIRequest {
    
    private var baseUrl: String {
        return "https://api.themoviedb.org/3/"
    }
    
    private var baseImageUrl: String {
        return "https://image.tmdb.org/t/p/"
    }
    
    var url: String {
        switch self {
        case .upcoming:
            return "\(baseUrl)movie/upcoming"
        case .genre:
            return "\(baseUrl)genre/movie/list"
        case .movieDetail(let id, _):
            return "\(baseUrl)movie/\(id)"
        case .searchMovie:
            return "\(baseUrl)search/movie"
        case .image(let url):
            return "\(baseImageUrl)\(ImageSize.w300)\(url)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var params: [String: String] {
        switch self {
        case .upcoming(let language, let page):
            return ["language": language, "page": "\(page)"]
        case .movieDetail(_ ,let language):
            return ["language": language.type]
        case .searchMovie(let query, let language, let page):
            return ["query": query, "language": language, "page": "\(page)", "include_adult": "false"]
        default:
            return [:]
        }
    }
    
    enum ImageSize: String {
        case w45
        case w92
        case w154
        case w185
        case w300
        case w342
        case w500
        case h632
        case w780
        case w1280
        case original
    }
    
    enum Language: String {
        case enUS
        
        var type: String {
            switch  self {
            case .enUS:
                return "en-US"
            }
        }
    }
}
