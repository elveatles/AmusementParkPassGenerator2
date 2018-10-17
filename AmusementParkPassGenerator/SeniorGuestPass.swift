//
//  SeniorGuestPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

class SeniorGuestPass: GuestPass {
    static let ageCutoff = 65
    
    override class var typeDisplayName: String {
        return "Senior Guest Pass"
    }
    
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        return [.firstName, .lastName, .dateOfBirth]
    }
    
    override func swipe(rideAccess: RideAccess, checkSwipeTime: Bool = true) -> SwipeResult {
        switch rideAccess {
        case .all, .skipLines: return createSwipeResult(accessible: true, checkSwipeTime: checkSwipeTime)
        }
    }
    
    override func swipe(discountType: DiscountType) -> Float {
        switch discountType {
        case .food: return 0.1
        case .merchandise: return 0.1
        }
    }
}
