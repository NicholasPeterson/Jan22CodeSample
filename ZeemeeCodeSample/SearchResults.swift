//
//  SearchResults.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import Foundation

class SearchResults: Decodable, Hashable {
    let query: String
    let results: [Cocktail]
    
    init(query: String, results: [Cocktail]) {
        self.query = query
        self.results = results
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(query)
        results.forEach { result in
            hasher.combine(result.idDrink)
        }
      }
    
    static func == (lhs: SearchResults, rhs: SearchResults) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
