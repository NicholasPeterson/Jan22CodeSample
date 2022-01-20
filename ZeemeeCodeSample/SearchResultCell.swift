//
//  SearchResultCell.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit

class SearchResultCell: UITableViewCell {
    static let reuseIdentifier = "SearchResultCell"
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let instructionsLabel = UILabel()
//    let imageView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        instructionsLabel.numberOfLines = 2
        
        safelyAddSubview(titleLabel)
        safelyAddSubview(categoryLabel)
        safelyAddSubview(instructionsLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        
        instructionsLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true
        instructionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22).isActive = true

    }
    
    func populate(with cocktail: Cocktail) {
        titleLabel.text = cocktail.strDrink
        categoryLabel.text = cocktail.strCategory
        instructionsLabel.text = cocktail.strInstructions
//        imageView
    }
}

