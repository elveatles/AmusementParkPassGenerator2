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
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        return [.dateOfBirth]
    }
    
    override class var typeDisplayName: String {
        return "Child Guest Pass"
    }
    
    /// The age that the child must be younger than for this pass
    static let ageCutoff = 5
}
