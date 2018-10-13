//
//  VendorPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Pass for a vendor entrant
class VendorPass: Pass {
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        // date of visit is automatically filled in
        return [.firstName, .lastName, .company, .dateOfBirth]
    }
}
