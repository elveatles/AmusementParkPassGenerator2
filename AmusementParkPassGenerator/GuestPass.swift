//
//  GuestPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Base class for guest passes
class GuestPass: Pass {
    override class var typeDisplayName: String {
        return "Classic Guest Pass"
    }
    
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        switch parkArea {
        case .amusement: return createSwipeResult(accessible: true)
        default: return createSwipeResult(accessible: false)
        }
    }
    
    override func swipe(rideAccess: RideAccess) -> SwipeResult {
        switch rideAccess {
        case .all: return createSwipeResult(accessible: true, checkSwipeTime: true)
        default: return createSwipeResult(accessible: false, checkSwipeTime: true)
        }
    }
}
