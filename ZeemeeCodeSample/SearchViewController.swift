//
//  SearchViewController.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit

class SearchViewController: UIViewController {
    let internalView = SearchView()
    let cocktailService = CocktailService()
    
    override func loadView() {
        view = internalView
    }
}

class SearchView: UIView {
    
}
