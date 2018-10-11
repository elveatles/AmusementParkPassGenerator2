//
//  ManagerPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Park pass for a manager
class ManagerPass: EmployeePass {
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        switch parkArea {
        case .amusement, .kitchen, .rideControl, .maintenance, .office:
            return createSwipeResult(accessible: true)
        }
    }
    
    override func swipe(discountType: DiscountType) -> Float {
        switch discountType {
        case .food: return 0.25
        case .merchandise: return 0.25
        }
    }
}
