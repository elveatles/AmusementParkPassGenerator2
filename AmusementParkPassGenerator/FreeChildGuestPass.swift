//
//  FreeChildGuestPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Free Guest Pass for a child
class FreeChildGuestPass: GuestPass {
    /// The age that the child must be younger than for this pass
    static let ageCutoff = 5
    
    /**
     Create the free child guest pass.
     
     - Parameter entrant: The entrant information.
     - Throws: `PassError.missingInformation`
                if the entrant date of birth is not provided.
                `PassError.wrongAge`
                if the entrant is too old to apply for this type of pass.
    */
    override init(entrant: Entrant) throws {
        try super.init(entrant: entrant)
        
        guard let dateOfBirth = entrant.dateOfBirth else {
            throw PassError.missingInformation(description: "Missing date of birth.")
        }
        
        let now = Date()
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: now)
        guard age.year! < FreeChildGuestPass.ageCutoff else {
            throw PassError.wrongAge(description: "Entrant must be younger than \(FreeChildGuestPass.ageCutoff). age: \(age)")
        }
    }
}
