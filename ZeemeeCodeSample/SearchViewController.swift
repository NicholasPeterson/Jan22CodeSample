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
    var tableViewDatasource: SearchResultsTableDatasource?
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Search"
        self.edgesForExtendedLayout = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = internalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    func setupTable() {
        internalView.resultsTable.register(ResultCell.self, forCellReuseIdentifier:ResultCell.reuseIdentifier)
        
        tableViewDatasource = SearchResultsTableDatasource(tableView: internalView.resultsTable) {
            (tableView, indexPath, cocktail) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultCell.reuseIdentifier,
                                                     for: indexPath) as! ResultCell
                        cell.populate(with: cocktail)
                        return cell
        }
        
    }

}

class SearchView: UIView {
    let searchTextField = UITextField()
    let resultsTable = UITableView()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        searchTextField.backgroundColor = .secondarySystemBackground
        searchTextField.layer.cornerRadius = 4
        
        safelyAddSubview(searchTextField)
        safelyAddSubview(resultsTable)
        
        searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        resultsTable.topAnchor.constraint(equalTo: searchTextField.bottomAnchor).isActive = true
        resultsTable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        resultsTable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        resultsTable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
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

class SearchResultsTableDatasource: UITableViewDiffableDataSource <SearchResults, Cocktail> {
    
}
