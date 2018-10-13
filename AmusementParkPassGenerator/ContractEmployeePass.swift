//
//  ContractEmployeePass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Park pass for Hourly Employee - Maintenance
class ContractEmployeePass: EmployeePass {
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        return [.projectNumber, .firstName, .lastName, .streetAddress, .city, .state, .zipCode]
    }
}
