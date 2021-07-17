//
//  Constants.swift
//  News
//
//  Created by RKAnjel on 7/15/21.
//

import Foundation

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey="
        static let searchBaseURL = "https://newsapi.org/v2/everything?"
    }

    struct APIKey {
        static let apiKey = "Your Api token"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
