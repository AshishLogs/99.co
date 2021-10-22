//
//  NetworkErrors.swift
//  99
//
//  Created by MegaMind on 21/10/21.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case server
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .server:
            return "Server Error"
        case .unknown:
            return "Unknown Error Occur"
        }
    }
}
