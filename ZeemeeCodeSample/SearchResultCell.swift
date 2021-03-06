//
//  SearchResultCell.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit

class SearchResultCell: UITableViewCell {
    static let reuseIdentifier = "SearchResultCell"
    let titleLabel = UILabel().withFont(.boldSystemFont(ofSize: 16))
    let categoryLabel = UILabel().withFont(.boldSystemFont(ofSize: 11)).withTextColor(.systemGray)
    let instructionsLabel = UILabel().withFont(.systemFont(ofSize: 13))
    let image = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        image.image = nil
    }
    
    func setupViews() {
        instructionsLabel.numberOfLines = 2
        image.layer.cornerRadius = 22
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        
        safelyAddSubview(titleLabel)
        safelyAddSubview(categoryLabel)
        safelyAddSubview(instructionsLabel)
        safelyAddSubview(image)

        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22).isActive = true

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true

        instructionsLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 3).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        instructionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22).isActive = true
    }
    
    func populate(with cocktail: LiteCocktail) {
        titleLabel.text = cocktail.strDrink
        categoryLabel.text = cocktail.strCategory.uppercased()
        instructionsLabel.text = cocktail.strInstructions
        image.load(url: URL(string: cocktail.strDrinkThumb)!)
    }
}

