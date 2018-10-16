//
//  EntrantSubtype.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// All entrant subtypes for guests, employees, managers, and vendors
enum EntrantSubtype {
    // Guest
    case childGuest
    case classicGuest
    case seniorGuest
    case vipGuest
    case seasonPassGuest
    
    // Employee
    case hourlyEmployeeFoodServices
    case hourlyEmployeeRideServices
    case hourlyEmployeeMaintenance
    case contractEmployee
    
    // Manager
    case manager
    
    // Vendor
    case vendor
    
    /// Display names for guest types
    static let guestDisplayNames: [EntrantSubtype: String] = [
        .childGuest: "Child",
        .classicGuest: "Adult",
        .seniorGuest: "Senior",
        .vipGuest: "VIP",
        .seasonPassGuest: "Season Pass"]
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
    
    /**
     Get the required entrant information needed for an entrant subtype.
     
     - Parameter entrantSubtype: The entrant subtype to get the required fields for.
     - Returns: The required fields for the specific entrant subtype.
    */
    var requiredEntrantInfo: Set<EntrantInfo> {
        switch self {
        // Guest passes
        case .childGuest: return FreeChildGuestPass.requiredEntrantInfo
        case .classicGuest: return GuestPass.requiredEntrantInfo
        case .seniorGuest: return SeniorGuestPass.requiredEntrantInfo
        case .vipGuest: return VIPGuestPass.requiredEntrantInfo
        case .seasonPassGuest: return SeasonGuestPass.requiredEntrantInfo
        // Employee passes
        case .hourlyEmployeeFoodServices: return HourlyEmployeeFoodServicesPass.requiredEntrantInfo
        case .hourlyEmployeeRideServices: return HourlyEmployeeRideServicesPass.requiredEntrantInfo
        case .hourlyEmployeeMaintenance: return HourlyEmployeeMaintenancePass.requiredEntrantInfo
        case .contractEmployee: return ContractEmployeePass.requiredEntrantInfo
        // Management passes
        case .manager: return ManagerPass.requiredEntrantInfo
        // Vendor passes
        case .vendor: return VendorPass.requiredEntrantInfo
        }
    }
}
