//
//  Endpoints.swift
//  99
//
//  Created by MegaMind on 21/10/21.
//

import Foundation

enum Endpoints {
    case productList
    case productDetails(id: String)
        
    var path : String {
        switch self {
        case .productList:
            return "listings.json"
        case .productDetails(let id):
            return "details/\(id).json"
        }
    }
}
