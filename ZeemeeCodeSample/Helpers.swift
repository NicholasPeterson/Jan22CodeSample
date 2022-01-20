//
//  Helpers.swift
//  ZeemeeCodeSample
//
//  Created by Nicholas Peterson on 1/19/22.
//

import UIKit
import Combine

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

/// Creates a text published for views to subscribe to
/// Adopted from https://cocoacasts.com/combine-fundamentals-observing-a-text-field-with-combine
extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }

}
