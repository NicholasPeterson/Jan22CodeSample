//
//  CocktailService.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit

class CocktailService {
    struct CocktailServiceError: Error {
        let message: String
        
        init(_ message: String) {
            self.message = message
        }
    }
    
    let rootURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    func search(query: String,
                error: @escaping ()->(CocktailServiceError),
                success: @escaping ()->([Cocktail])) {
        
    }
    
    func detail(query: String,
                error: @escaping ()->(CocktailServiceError),
                success: @escaping ()->([Cocktail])) {
        
    }
}

