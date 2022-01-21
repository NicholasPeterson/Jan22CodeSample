//
//  SearchManager.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import Foundation
import Combine


/// Coordinates the Interactions between the user and our data layer
class SearchManager {
    private let cocktailService = CocktailService()
    private var autoSubmitTimeout: AnyCancellable?
    private var currentSubmission: AnyCancellable?
    
    /// The current dataset that is expected on the UI
    @Published var searchResults: SearchResults = .Empty
    
    /// The current search query.
    /// This may not be the same as the query in `.searchResults`.
    @Published var currentSearchQuery = "" {
        didSet {
            autoSubmitTimeout?.cancel()
            currentSubmission?.cancel()
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
    
    
    private func triggerAutoSubmit(query: String) {
        currentSubmission = cocktailService.searchPublisher(for: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {result in
                if case Subscribers.Completion.failure(let error) = result {
                    print("[Error] search(\(query)) - \(error)")
                    self.searchResults = .Empty // May need to check is the error is a cancellation.
                }
            }, receiveValue: { results in
                self.searchResults = results
            })
    }
}
