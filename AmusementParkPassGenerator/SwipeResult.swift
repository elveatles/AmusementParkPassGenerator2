//
//  SwipeResult.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Represents the result of a park pass swipe
struct SwipeResult: CustomStringConvertible {
    /// Whether the wipe was successful or not
    let success: Bool
    /// A message to display to the user
    var message: String = ""
    
    var description: String {
        return "success: \(success), message: \(message)"
    }
    
    /**
     Create an instance that is successful or not.
     
     - Parameter success: true if a swipe was successful.
     - Parameter message: The message to show the user. If nil, a default message is used based on whether success is true or not.
    */
    init(success: Bool, message: String? = nil) {
        self.success = success
        
        if let msg = message {
            self.message = msg
        } else {
            if success {
                self.message = "Welcome!"
            } else {
                self.message = "You are not allowed in this area."
            }
        }
    }
}
