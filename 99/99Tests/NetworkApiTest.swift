//
//  ProductViewModelTest.swift
//  99Tests
//
//  Created by MegaMind on 23/10/21.
//

import XCTest
import Combine
@testable import _9

class ProductViewModelTests : XCTestCase {
    
    private var disposeBags = Set<AnyCancellable>()
    
    override class func setUp() {
        
    }
    
    func test_productListFromApi() {
        Network.manager.performRequest(endpoint: .productList, type: ProductLists.self)
            .sink { (completion) in
            } receiveValue: { (lists) in
                XCTAssertTrue(lists.count > 0)
            }
            .store(in: &disposeBags)
    }
    
    func test_productDetailsApi() {
        Network.manager.performRequest(endpoint: .productDetails(id: "0"), type: ProductDetailsModel.self)
            .sink { (completion) in
            } receiveValue: { (details) in
                XCTAssertNotNil(details)
            }
            .store(in: &disposeBags)
    }
            
}
