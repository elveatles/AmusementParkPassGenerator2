//
//  EmployeePass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// An employee park pass. Should be subclassed for specific employee types.
class EmployeePass: Pass {
    override class var typeDisplayName: String {
        return "Employee Pass"
    }
    
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        return [.firstName, .lastName, .streetAddress, .city, .state, .zipCode]
    }
    
    override func swipe(rideAccess: RideAccess) -> SwipeResult {
        switch rideAccess {
        case .all: return createSwipeResult(accessible: true, checkSwipeTime: true)
        default: return createSwipeResult(accessible: false, checkSwipeTime: true)
        }
    }
    
    override func swipe(discountType: DiscountType) -> Float {
        switch discountType {
        case .food: return 0.15
        case .merchandise: return 0.25
        }
    }
}
