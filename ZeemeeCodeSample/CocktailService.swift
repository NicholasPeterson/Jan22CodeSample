//
//  CocktailService.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import Combine
import Foundation

/// CocktailService provides access the thecocktaildb via Combine publishers.
///
class CocktailService {
    typealias SearchPublisher = AnyPublisher<SearchResults, Error>
    typealias DetailPublisher = AnyPublisher<Cocktail, Error>
    
    private let urlSession = URLSession.shared
    
    func searchPublisher(for query: String) -> SearchPublisher {
        let request = SearchRequest(query: query)
        
        return urlSession.publisher(for: request)
            .map({ SearchResults(query: query, results: $0) })
            .eraseToAnyPublisher()
    }
    
    func detailPublisher(for id: String) -> DetailPublisher {
        let request = DetailRequest(id: id)
        
        return (urlSession.publisher(for: request) as AnyPublisher<[Cocktail], Error>)
            .tryMap({
                guard let cocktail = $0.last else { throw ServiceError("Unknown Decoding Error") }
                return cocktail
            })
            .eraseToAnyPublisher()

    }
    
    struct ServiceError: Error {
        let message: String
        
        init(_ message: String) {
            self.message = message
        }
    }
}

/// Specificly modeled API Endpoints.
extension CocktailService {
    struct SearchRequest: CocktailServiceRequest {
        let endpoint = "search.php"
        let query: String
        var body : [String: String] {
            get {
                ["s": query]
            }
        }
    }
    
    struct DetailRequest: CocktailServiceRequest {
        let endpoint = "lookup.php"
        let id: String
        var body : [String: String] {
            get {
                ["i": id]
            }
        }
    }
}
