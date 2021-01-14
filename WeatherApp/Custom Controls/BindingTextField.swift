//
//  BindingTextField.swift
//  WeatherApp
//
//  Created by Juan Bonforti on 14/01/2021.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    // MARK: - Vars
    var textChangeClosure: (String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

// MARK: - Extensions
extension BindingTextField {
    
    func bind(callback: @escaping (String) -> ()) {
        textChangeClosure = callback
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            textChangeClosure(text)
        }
    }
    
}
