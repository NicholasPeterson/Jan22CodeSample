//
//  SearchManager.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import Foundation
import Combine

class SearchManager {
    let cocktailService = CocktailService()
    
    @Published var searchResults: SearchResults = .Empty
    @Published var currentSearchQuery = "" {
        didSet {
            autoSubmitTimeout?.cancel()
            autoSubmitTimeout = Timer.publish(every: 0.5,
                                              on: .main,
                                              in: .default)
                    .autoconnect()
                    .sink {[weak self] date in
                        guard let self = self else { return }
                        self.triggerAutoSubmit(query: self.currentSearchQuery)
                        self.autoSubmitTimeout?.cancel()
                    }
        }
    }
    
    var autoSubmitTimeout: Cancellable?
    
    func triggerAutoSubmit(query: String) {
        cocktailService.search(query: query) {_ in
            print("fail")
        } success: { [weak self] results in
            /* Discard stale results */
            guard let self = self, results.query == self.currentSearchQuery else { return  }
            self.searchResults = results
        }
    }
}
