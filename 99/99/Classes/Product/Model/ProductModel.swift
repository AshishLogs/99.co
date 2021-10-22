//
//  ProductModel.swift
//  99
//
//  Created by MegaMind on 21/10/21.
//

import Foundation

// MARK: - ProductListElement
struct ProductListElement: Codable {
    let address: ProductListAddress
    let attributes: ProductListAttributes
    let category, completedAt: String
    let id: Int
    let photo: String
    let projectName: String
    let tenure: Int

    enum CodingKeys: String, CodingKey {
        case address, attributes, category
        case completedAt = "completed_at"
        case id, photo
        case projectName = "project_name"
        case tenure
    }
    
    var fullAddress : String {
        return self.address.streetName + ", " + self.address.district
    }
    
    var projectDetails :  String {
        let projectDetails = [self.category, self.completedAt, "\(self.tenure)"]
        return projectDetails.joined(separator: " • ")
    }
    
    var productAttributes :  String {
        let projectAttributes = ["\(self.attributes.bedrooms) Beds", "\(self.attributes.bathrooms) Baths", "\(self.attributes.areaSize) sqft"]
        return projectAttributes.joined(separator: " • ")
    }
    
    var finalPrice : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        let number = NSNumber(value: self.attributes.price)
        let formattedValue = formatter.string(from: number) ?? "0"
        return "$\(formattedValue)/mo"
    }
    
}

// MARK: - ProductListAddress
struct ProductListAddress: Codable {
    let district, streetName: String

    enum CodingKeys: String, CodingKey {
        case district
        case streetName = "street_name"
    }
}

// MARK: - ProductListAttributes
struct ProductListAttributes: Codable {
    let areaSize, bathrooms, bedrooms, price: Int

    enum CodingKeys: String, CodingKey {
        case areaSize = "area_size"
        case bathrooms, bedrooms, price
    }
}

typealias ProductLists = [ProductListElement]
