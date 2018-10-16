//
//  EntrantInfo.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// All of the different fields for entrant information
enum EntrantInfo {
    case dateOfBirth
    case ssn
    case projectNumber
    case firstName
    case lastName
    case company
    case streetAddress
    case city
    case state
    case zipCode
    
    /// The user-frieldy display name
    var displayName: String {
        switch self{
        case .dateOfBirth: return "Date of Birth"
        case .ssn: return "SSN"
        case .projectNumber: return "Project #"
        case .firstName: return "First Name"
        case .lastName: return "Last Name"
        case .company: return "Company"
        case .streetAddress: return "Street Address"
        case .city: return "City"
        case .state: return "State"
        case .zipCode: return "Zip Code"
        }
    }
}
