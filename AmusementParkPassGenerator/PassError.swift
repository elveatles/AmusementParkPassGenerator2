//
//  PassError.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Error relating to park passes
enum PassError: Error {
    /// An entrant is missing information required to create a type of pass
    case missingInformation(description: String)
    /// An entrant is the wrong age for a certain type of pass
    case wrongAge(description: String)
}
