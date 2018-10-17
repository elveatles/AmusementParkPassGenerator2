//
//  ContractEmployeePass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Park pass for Hourly Employee - Maintenance
class ContractEmployeePass: EmployeePass {
    override class var typeDisplayName: String {
        return "Contract Employee Pass"
    }
    
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        return [.projectNumber, .firstName, .lastName, .streetAddress, .city, .state, .zipCode]
    }
    
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        switch parkArea {
        case .amusement, .kitchen: return createSwipeResult(accessible: true)
        default: return createSwipeResult(accessible: false)
        }
    }
    
    override func swipe(discountType: DiscountType) -> Float {
        switch discountType {
        case .food: return 0.0
        case .merchandise: return 0.0
        }
    }
}
