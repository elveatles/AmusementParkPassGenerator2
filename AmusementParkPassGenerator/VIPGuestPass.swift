//
//  VIPGuestPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// VIP Guest Pass
class VIPGuestPass: GuestPass {
    override func swipe(rideAccess: RideAccess) -> SwipeResult {
        switch rideAccess {
        case .all, .skipLines: return createSwipeResult(accessible: true)
        }
    }
    
    override func swipe(discountType: DiscountType) -> Float {
        switch discountType {
        case .food: return 0.1
        case .merchandise: return 0.2
        }
    }
}
