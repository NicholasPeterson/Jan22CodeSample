//
//  CocktailServiceRequest.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/20/22.
//

import Foundation
import Combine

/// Models our API requests and implements some generic translation to the native url handling features.
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

/// Provides a generic publisher and makes the requests to urlSession for us using our own request model.
extension URLSession {
    func publisher<T: Decodable>(
        for request: CocktailServiceRequest,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, Error> {
        do {
            decoder.dateDecodingStrategy = .iso8601
            let urlRequest = try request.asURLRequest()
            return dataTaskPublisher(for: urlRequest)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                    return element.data
                    }
                .decode(type: [String: T].self, decoder: decoder)
                .tryMap({ containerDict in
                    guard let contents = containerDict["drinks"] else {
                        throw CocktailService.ServiceError("Expected root node 'drinks' to exist in response; got \(containerDict)")
                        }
                    return contents
                })
                .eraseToAnyPublisher()
            
        } catch { return Fail(error: error).eraseToAnyPublisher() }
    }
}
