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

class ResultCell: UITableViewCell {
    static let reuseIdentifier = "resultCell"
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let instructionsLabel = UILabel()
    let imageView = UIImageView()


}
