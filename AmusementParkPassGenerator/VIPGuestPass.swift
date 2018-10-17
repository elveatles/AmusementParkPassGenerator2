//
//  VIPGuestPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// VIP Guest Pass
class VIPGuestPass: GuestPass {
    override class var typeDisplayName: String {
        return "VIP Guest Pass"
    }
    
    override func swipe(rideAccess: RideAccess, checkSwipeTime: Bool = true) -> SwipeResult {
        switch rideAccess {
        case .all, .skipLines: return createSwipeResult(accessible: true, checkSwipeTime: checkSwipeTime)
        }
    }
    
    override func swipe(discountType: DiscountType) -> Float {
        switch discountType {
        case .food: return 0.1
        case .merchandise: return 0.2
        }
    }
}
