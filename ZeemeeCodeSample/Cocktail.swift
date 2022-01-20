//
//  Cocktail.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//
// Omits:
// International Strings

import Foundation
struct Cocktail {
    let idDrink: Int
    let strDrink: String
    let strDrinkAlternate: String?
    let strTags: String?
    let strVideo: String?
    let strCategory: String
    let strIBA: String?
    let strAlcoholic: String?
    let strGlass: String
    let strInstructions: String
    let strDrinkThumb: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strImageSource: String?
    let strImageAttribution: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: Date
}

extension Cocktail {
    typealias ingredientPair = (ingredient: String?, measure: String?)
    var ingredientList : [ingredientPair] {
        [(strIngredient1, strMeasure1),
         (strIngredient2, strMeasure2),
         (strIngredient3, strMeasure3),
         (strIngredient4, strMeasure4),
         (strIngredient5, strMeasure5),
         (strIngredient6, strMeasure6),
         (strIngredient7, strMeasure7),
         (strIngredient8, strMeasure8),
         (strIngredient9, strMeasure9),
         (strIngredient10, strMeasure10),
         (strIngredient11, strMeasure11),
         (strIngredient12, strMeasure12),
         (strIngredient13, strMeasure13),
         (strIngredient14, strMeasure14),
         (strIngredient15, strMeasure15)]
    }
    
    func TEMPMOCK() -> Cocktail {
        return Cocktail(idDrink: 12933, strDrink: "A Drink", strDrinkAlternate: nil, strTags: nil, strVideo: nil, strCategory: "A Category", strIBA: nil, strAlcoholic: "Alcoholic", strGlass: "Martini", strInstructions: "Some Instructions go here that are pretty long. but not so long that the take up the entire view. but enough to tell users how to make the drink", strDrinkThumb: "https://example.com", strIngredient1: "An ingredient", strIngredient2: "Another Ingredient", strIngredient3: "Love", strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strMeasure1: "1 cup", strMeasure2: "2 oz", strMeasure3: "A Heap Of", strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strImageSource: nil, strImageAttribution: nil, strCreativeCommonsConfirmed: "No", dateModified: Date())
    }
}
