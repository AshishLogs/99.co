//
//  Network.swift
//  99
//
//  Created by MegaMind on 21/10/21.
//

import Foundation
import Combine

class Network {
    
    static let manager = Network()
    
    private init() {}
    
    private let baseURL = "https://ninetyninedotco-b7299.asia-southeast1.firebasedatabase.app/"
    
    private var disposeBags = Set<AnyCancellable>()
    
    func performRequest<T: Decodable>(endpoint: Endpoints, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL.init(string: self.baseURL + endpoint.path) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                },
                receiveValue: { promise(.success($0)) })
                .store(in: &self.disposeBags)
        }
    }    
}
