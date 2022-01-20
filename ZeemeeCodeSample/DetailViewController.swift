//
//  DetailViewController.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit

class DetailViewController: UIViewController {
    let internalView = DetailView()
    let cocktail: Cocktail
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = cocktail.strDrink
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = internalView
    }
    
    override func viewDidLoad() {
        internalView.populate(with: cocktail)
    }

}

class DetailView: UIView {
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let instructionsHeader = UILabel().withText("INSTRUCTIONS")
    let instructionsLabel = UILabel()
    let ingredientsHeader = UILabel().withText("INGREDIENTS") // Will get overridden
    let ingredientList = IngredientList()
    let glassHeader = UILabel().withText("GLASS NEEDED")
    let glassLabel = UILabel()
    let categoryBadge = UIView()
    let categoryBadgeLabel = UILabel()
    let shareCTA = UIButton()
   
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .systemBackground
        instructionsLabel.numberOfLines = 0
        instructionsLabel.lineBreakMode = .byWordWrapping
        
        categoryBadge.backgroundColor = .systemGreen
        categoryBadge.layer.cornerRadius = 4
        categoryBadgeLabel.textColor = .white

        ingredientList.axis = .vertical
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        shareCTA.backgroundColor = .systemBlue
        shareCTA.layer.cornerRadius = 7
        
        safelyAddSubview(scrollView)
        scrollView.safelyAddSubview(imageView)
        
        scrollView.safelyAddSubview(categoryBadge)
        categoryBadge.safelyAddSubview(categoryBadgeLabel)
        
        scrollView.safelyAddSubview(instructionsHeader)
        scrollView.safelyAddSubview(instructionsLabel)
        scrollView.safelyAddSubview(ingredientsHeader)
        scrollView.safelyAddSubview(ingredientList)
        scrollView.safelyAddSubview(glassHeader)
        scrollView.safelyAddSubview(glassLabel)
        scrollView.safelyAddSubview(shareCTA)
        
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: 0).isActive = true
        
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -12).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        categoryBadge.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -22).isActive = true
        categoryBadge.leadingAnchor.constraint(equalTo: instructionsHeader.leadingAnchor, constant: 0).isActive = true

        categoryBadgeLabel.topAnchor.constraint(equalTo: categoryBadge.topAnchor, constant: 1).isActive = true
        categoryBadgeLabel.leadingAnchor.constraint(equalTo: categoryBadge.leadingAnchor, constant: 7).isActive = true
        categoryBadgeLabel.bottomAnchor.constraint(equalTo: categoryBadge.bottomAnchor, constant: -1).isActive = true
        categoryBadgeLabel.trailingAnchor.constraint(equalTo: categoryBadge.trailingAnchor, constant: -7).isActive = true

        instructionsHeader.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
        instructionsHeader.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 22).isActive = true
        instructionsHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22).isActive = true
        
        instructionsLabel.topAnchor.constraint(equalTo: instructionsHeader.bottomAnchor, constant: 12).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22).isActive = true
        
        ingredientsHeader.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 12).isActive = true
        ingredientsHeader.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22).isActive = true
        ingredientsHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22).isActive = true
        
        ingredientList.topAnchor.constraint(equalTo: ingredientsHeader.bottomAnchor, constant: 12).isActive = true
        ingredientList.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22).isActive = true
        ingredientList.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22).isActive = true
        
        glassHeader.topAnchor.constraint(equalTo: ingredientList.bottomAnchor, constant: 12).isActive = true
        glassHeader.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22).isActive = true
        glassHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22).isActive = true
        
        glassLabel.topAnchor.constraint(equalTo: glassHeader.bottomAnchor, constant: 12).isActive = true
        glassLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -22).isActive = true
        glassLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 22).isActive = true
        
        shareCTA.topAnchor.constraint(equalTo: glassLabel.bottomAnchor, constant: 12).isActive = true
        shareCTA.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        shareCTA.widthAnchor.constraint(equalToConstant: 150).isActive = true
        shareCTA.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -22).isActive = true    }
    
    func populate(with cocktail: Cocktail) {
        imageView.load(url: URL(string: cocktail.strDrinkThumb)!)
        categoryBadgeLabel.text = cocktail.strCategory.uppercased()
        instructionsLabel.text = cocktail.strInstructions
        ingredientsHeader.text = "\(cocktail.ingredientList.count) INGREDIENTS"
        ingredientList.ingredientPairs = cocktail.ingredientList
        glassLabel.text = cocktail.strGlass
    }
}

class IngredientList: UIStackView {
    var ingredientPairs = [Cocktail.ingredientPair]() {
        didSet {
            updateContents()
        }
    }
    
    private func updateContents() {
        let lineItems = ingredientPairs.map { IngredientLineItem(with: $0) }
        arrangedSubviews.forEach { removeArrangedSubview($0) }
        lineItems.forEach { addArrangedSubview($0) }
    }
    
    class IngredientLineItem: UIView {
        let measureLabel = UILabel()
        let ingredientLabel = UILabel()
        
        init(with pair: Cocktail.ingredientPair) {
            super.init(frame: .zero)
            measureLabel.text = pair.measure
            ingredientLabel.text = pair.ingredient
            
            safelyAddSubview(measureLabel)
            safelyAddSubview(ingredientLabel)

            measureLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            measureLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            measureLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

            ingredientLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            ingredientLabel.leadingAnchor.constraint(equalTo: measureLabel.trailingAnchor).isActive = true
            ingredientLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            ingredientLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}


