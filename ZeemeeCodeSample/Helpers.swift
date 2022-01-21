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
    func withFont(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    
    func withTextColor(_ color: UIColor) -> UILabel {
        self.textColor = color
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

extension UIButton {
    func withText(_ text: String?) -> UIButton {
        setTitle(text, for: .normal)
        return self
    }
}

///Inlue of SDWebImage
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIView {
    static func makeSeparator() -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .systemFill
        return view
    }
}
