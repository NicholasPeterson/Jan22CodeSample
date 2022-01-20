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
    init(cocktail: Cocktail){
        self.cocktail = cocktail
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = cocktail.strDrink
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
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let instructionsHeader = UILabel()
    let instructionsLabel = UILabel()
    let ingredientsHeader = UILabel()
    let ingredientList = IngredientList()
    let glassHeader = UILabel()
    let glassLabel = UILabel()
    let CTAWrapper = UIView()
    let shareCTA = UIButton()
    let shareTop = UIButton()
    let back = UIButton()
    
    func populate(with cocktail: Cocktail) {
        titleLabel.text = cocktail.strDrink
//        imageView.image = Image()
        instructionsLabel.text = cocktail.strInstructions
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
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}


