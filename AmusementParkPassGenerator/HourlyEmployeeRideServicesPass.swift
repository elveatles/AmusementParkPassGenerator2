//
//  HourlyEmployeeRideServicesPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Park pass for Hourly Employee - Ride Services
class HourlyEmployeeRideServicesPass: EmployeePass {
    override class var typeDisplayName: String {
        return "Hourly Employee - Ride Services Pass"
    }
    
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        switch parkArea {
        case .amusement, .rideControl: return createSwipeResult(accessible: true)
        default: return createSwipeResult(accessible: false)
        }
    }
}
