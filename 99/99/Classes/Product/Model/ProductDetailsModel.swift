//
//  ProductDetailsModel.swift
//  99
//
//  Created by MegaMind on 22/10/21.
//

import Foundation

// MARK: - ProductDetailsDetails
struct ProductDetailsModel: Codable {
    let address: ProductDetailsAddress?
    let attributes: ProductDetailsAttributes?
    let detailsDescription: String?
    let id: Int?
    let photo: String?
    let projectName: String?
    let propertyDetails: [ProductDetailsPropertyDetail]?

    enum CodingKeys: String, CodingKey {
        case address, attributes
        case detailsDescription = "description"
        case id, photo
        case projectName = "project_name"
        case propertyDetails = "property_details"
    }
    
    var finalPrice : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        let number = NSNumber(value: self.attributes?.price ?? 0)
        let formattedValue = formatter.string(from: number) ?? "0"
        return "$\(formattedValue)/mo"
    }

    
}

// MARK: - ProductDetailsAddress
struct ProductDetailsAddress: Codable {
    let mapCoordinates: ProductDetailsMapCoordinates?
    let subtitle, title: String?

    enum CodingKeys: String, CodingKey {
        case mapCoordinates = "map_coordinates"
        case subtitle, title
    }
}

// MARK: - ProductDetailsMapCoordinates
struct ProductDetailsMapCoordinates: Codable {
    let lat, lng: Double?
}

// MARK: - ProductDetailsAttributes
struct ProductDetailsAttributes: Codable {
    let areaSize, bathrooms, bedrooms, price: Int?

    enum CodingKeys: String, CodingKey {
        case areaSize = "area_size"
        case bathrooms, bedrooms, price
    }
}

// MARK: - ProductDetailsPropertyDetail
struct ProductDetailsPropertyDetail: Codable {
    let label, text: String?
}
