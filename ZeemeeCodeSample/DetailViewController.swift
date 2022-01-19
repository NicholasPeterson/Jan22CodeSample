//
//  DetailViewController.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit

class DetailViewController: UIViewController {
    let internalView = DetailView()
    
    override func loadView() {
        view = internalView
    }
}

class DetailView: UIView {
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let instructionsHeader = UILabel()
    let instructionsLabel = UILabel()
    let ingredientsHeader = UILabel()
    let ingredientStackView = UILabel()
    let glassHeader = UILabel()
    let glassLabel = UILabel()
    let CTAWrapper = UIView()
    let shareCTA = UIButton()
    let shareTop = UIButton()
    let back = UIButton()
    
}
