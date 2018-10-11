//
//  HourlyEmployeeMaintenancePass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Park pass for Hourly Employee - Maintenance
class HourlyEmployeeMaintenancePass: EmployeePass {
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        switch parkArea {
        case .amusement, .kitchen, .rideControl, .maintenance: return createSwipeResult(accessible: true)
        default: return createSwipeResult(accessible: false)
        }
    }
}
