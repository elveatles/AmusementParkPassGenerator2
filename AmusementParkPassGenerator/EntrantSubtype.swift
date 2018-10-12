//
//  EntrantSubtype.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// All entrant subtypes for guests, employees, managers, and vendors
enum EntrantSubtype {
    case childGuest
    case classicGuest
    case seniorGuest
    case vipGuest
    
    case hourlyEmployeeFoodServices
    case hourlyEmployeeRideServices
    case hourlyEmployeeMaintenance
    case contractEmployee
    
    case manager
    
    case vendor
    
    /// Display names for guest types
    static let guestDisplayNames: [EntrantSubtype: String] = [
        .childGuest: "Child",
        .classicGuest: "Adult",
        .seniorGuest: "Senior",
        .vipGuest: "VIP"]
    /// Display names for employee types
    static let employeeDisplayNames: [EntrantSubtype: String] = [
        .hourlyEmployeeFoodServices: "Food Services",
        .hourlyEmployeeRideServices: "Ride Services",
        .hourlyEmployeeMaintenance: "Maintenance",
        .contractEmployee: "Contract"
    ]
    /// Display names for manager types
    static let managerDisplayNames: [EntrantSubtype: String] = [
        .manager: "Manager"
    ]
    /// Display names for vendor types
    static let vendorDisplayNames: [EntrantSubtype: String] = [
        .vendor: "Vendor"
    ]
    
    /**
     Get the entrant subtype display names for a given entrant type.
     
     - Parameter entrantType: The type of entrant to get the subtype display names for.
     - Returns: The entrant subtype display names for a given entrant type.
    */
    static func displayNames(for entrantType: EntrantType) -> [EntrantSubtype: String] {
        switch entrantType {
        case .guest: return guestDisplayNames
        case .employee: return employeeDisplayNames
        case .manager: return managerDisplayNames
        case .vendor: return vendorDisplayNames
        }
    }
}
