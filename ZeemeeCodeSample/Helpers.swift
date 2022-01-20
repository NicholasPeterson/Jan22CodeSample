//
//  Helpers.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit

extension UIView {
    func safelyAddSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}

/// Passthroughs for configuring during view inits.
extension UILabel {
    func withText(_ text: String?) -> UILabel {
        self.text = text
        return self
    }
}
