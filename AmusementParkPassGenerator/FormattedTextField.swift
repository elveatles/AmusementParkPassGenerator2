//
//  FormattedTextField.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/15/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// A text field that formats input in real-time
class FormattedTextField: UITextField, UITextFieldDelegate {
    /// The format the text should be in
    /// # for numbers
    @IBInspectable var formatting: String = "##/##/####"
    
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
        
        // Updated text should not be longer than the format allows
        if updatedText.count > formatting.count {
            return false
        }
        
        // Loop through each character of updatedText to make sure it matches the formatting specified
        for (i, textChar) in updatedText.enumerated() {
            // Get the format character at the same index
            let index = formatting.index(formatting.startIndex, offsetBy: i)
            let formatChar = formatting[index]
            
            // Compare the formatting character with the actual character
            switch formatChar {
            case "#":
                // Make sure the character is a number
                if Int(String(textChar)) == nil {
                    return false
                }
            case "?":
                // Make sure the character is a letter (not a number)
                if Int(String(textChar)) != nil {
                    return false
                }
            default:
                // Default is the character should be the same as in the formatting string
                if textChar != formatChar {
                    return false
                }
            }
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
