//
//  MaxLengthTextField.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/15/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

class MaxLengthTextField: UITextField, UITextFieldDelegate {
    @IBInspectable var maxLength: Int = 100
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Unwrap text and convert NSRange to Range
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return true
        }
        
        // Get the text with the changes applied
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        // Check the length of the text against the max length
        if updatedText.count > maxLength {
            return false
        }
        
        return true
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
