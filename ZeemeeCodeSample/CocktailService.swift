//
//  CocktailService.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import Combine
import Foundation


class CocktailService {
    typealias SearchPublisher = AnyPublisher<SearchResults, Error>
    typealias DetailPublisher = AnyPublisher<Cocktail, Error>
    
    private let urlSession = URLSession.shared
    private let decoder = JSONDecoder()
    
    func searchPublisher(for query: String) -> SearchPublisher {
        do {
            let request = try SearchRequest(query: query).asURLRequest()
            
            return urlSession.dataTaskPublisher(for: request)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                    return element.data
                    }
                .decode(type: SearchResults.self, decoder: decoder)
                .eraseToAnyPublisher()
            
        } catch { return Fail(error: error).eraseToAnyPublisher() }
    }
    
    func detailPublisher(for id: String) -> DetailPublisher {
        do {
            let request = try DetailRequest(id: id).asURLRequest()
            
            return urlSession.dataTaskPublisher(for: request)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                    return element.data
                    }
                .decode(type: Cocktail.self, decoder: decoder)
                .eraseToAnyPublisher()
            
        } catch { return Fail(error: error).eraseToAnyPublisher() }
    }
    
    struct ServiceError: Error {
        let message: String
        
        init(_ message: String) {
            self.message = message
        }
    }
    
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

protocol CocktailServiceRequest {
    /// The method for this request, Currently only http-get is supported.
    var method: String { get }
    /// The API Endpoint
    var endpoint: String { get }
    /// The api-encoded version of the request paramenters
    var body: [String: String] { get }
    /// Returns a configured URLRequest. Currently only supports http-get method
    func asURLRequest() throws -> URLRequest
}

extension CocktailServiceRequest {
    var method: String { "GET" } // default to http_get because we arent supporting anything else right now.
    
    func asURLRequest() throws -> URLRequest {
        var urlBits = URLComponents()
        urlBits.scheme = "https"
        urlBits.host = "www.thecocktaildb.com"
        urlBits.path = "/api/json/v1/1/\(endpoint)"
        urlBits.queryItems = body.map{ (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = urlBits.url else {
            throw CocktailService.ServiceError("Unable to generate a URL with components [\(urlBits)]")
            
        }
        
        var request = URLRequest(url: url,
                        cachePolicy: .returnCacheDataElseLoad,
                   timeoutInterval: 10)
        
        request.httpMethod = method
        return request
    }
}


