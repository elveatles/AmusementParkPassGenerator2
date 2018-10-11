//
//  HourlyEmployeeFoodServicePass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Park pass for Hourly Employee - Food Services
class HourlyEmployeeFoodServicesPass: EmployeePass {
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        switch parkArea {
        case .amusement, .kitchen: return createSwipeResult(accessible: true)
        default: return createSwipeResult(accessible: false)
        }
    }
}
