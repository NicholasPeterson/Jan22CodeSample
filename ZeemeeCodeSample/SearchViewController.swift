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
    var currentSearchRequest: UserSearchRequest?
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Search"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = internalView
    }
    
    override func viewDidLoad() {
        setupTable()
    }
    
    func setupTable() {
        internalView.resultsTable.register(ResultCell.self, forCellReuseIdentifier:ResultCell.reuseIdentifier)
    }

}

class SearchView: UIView {
    let searchTextField = UITextField()
    let resultsTable = UITableView()
    
}

struct UserSearchRequest {
    let searchQuery: String
    let service: CocktailService
}

class ResultCell: UITableViewCell {
    static let reuseIdentifier = "resultCell"
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let instructionsLabel = UILabel()
//    let imageView = UIImageView()
    
    func populate(with cocktail: Cocktail) {
        titleLabel.text = cocktail.strDrink
        categoryLabel.text = cocktail.strCategory
        instructionsLabel.text = cocktail.strInstructions
//        imageView
    }
}
