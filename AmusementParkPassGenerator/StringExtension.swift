//
//  StringExtension.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/16/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

extension String {
    /**
     Check if an optional String is nil, empty, or has no content (just whitespace).
     
     - Parameter string: The value to check.
     - Returns: true if the string is nil or has no content.
    */
    static func isNilOrNothing(_ string: String?) -> Bool {
        guard let str = string else {
            return true
        }
        
        return str.isNothing
    }
    
    /**
     Get a string's trimmed self or nil.
     
     - Parameter string: The value to get back trimmed.
     - Returns: The trimmed string or nil.
    */
    static func nilOrTrimmed(_ string: String?) -> String? {
        guard let str = string else {
            return nil
        }
        
        return str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Check if the string is empty or has no content (just whitespace)
    var isNothing: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
