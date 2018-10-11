//
//  Swipeable.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Protocol for a swipeable object
protocol Swipeable {
    func swipe(parkArea: ParkArea) -> SwipeResult
    func swipe(rideAccess: RideAccess) -> SwipeResult
    func swipe(discountType: DiscountType) -> Float
}
