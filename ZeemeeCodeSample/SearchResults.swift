//
//  SearchResults.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import Foundation

class SearchResults: Decodable, Hashable {
    let query: String
    let results: [LiteCocktail]
    
    
    init(query: String, results: [LiteCocktail]) {
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

extension SearchResults {
    static let Empty = SearchResults(query: "", results: [])
}

struct LiteCocktail: Decodable, Hashable {
    let idDrink: String
    let strDrink: String
    let strInstructions: String
    let strDrinkThumb: String
    let strCategory: String
}
