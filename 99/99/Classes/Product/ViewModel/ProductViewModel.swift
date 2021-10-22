//
//  ProductViewModel.swift
//  99
//
//  Created by MegaMind on 21/10/21.
//

import Foundation
import Combine

class ProductListViewModel {
    
    private var disposeBags = Set<AnyCancellable>()
    
    var products      = PassthroughSubject<ProductLists, Never>()
    var productDetail = PassthroughSubject<ProductDetailsModel, Never>()
    
    func getProductList() {
        Network.manager.performRequest(endpoint: .productList, type: ProductLists.self)
            .sink { (completion) in
                switch completion {
                case .finished:
                    debugPrint("Finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self](lists) in
                self?.products.send(lists)
            }
            .store(in: &disposeBags)
    }
    
    
    
    func getProductDetails(id: String) {
        Network.manager.performRequest(endpoint: .productDetails(id: id), type: ProductDetailsModel.self)
            .sink { (completion) in
                switch completion {
                case .finished:
                    debugPrint("Finished")
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            } receiveValue: { [weak self](details) in
                self?.productDetail.send(details)
            }
            .store(in: &disposeBags)
    }
}
