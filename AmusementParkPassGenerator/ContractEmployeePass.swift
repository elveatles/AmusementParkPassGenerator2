//
//  ContractEmployeePass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Park pass for Hourly Employee - Maintenance
class ContractEmployeePass: EmployeePass {
    override class var typeDisplayName: String {
        return "Contract Employee Pass"
    }
    
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        return [.projectNumber, .firstName, .lastName, .streetAddress, .city, .state, .zipCode]
    }
    
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        guard let projectNumber = entrant.projectNumber else {
            print("ContractEmployeePass.swipe(parkArea:): entrant does not have a project number")
            return createSwipeResult(accessible: false)
        }
        
        switch projectNumber {
        case 1001:
            switch parkArea {
            case .amusement, .rideControl: return createSwipeResult(accessible: true)
            default: return createSwipeResult(accessible: false)
            }
        case 1002:
            switch parkArea {
            case .amusement, .rideControl, .maintenance: return createSwipeResult(accessible: true)
            default: return createSwipeResult(accessible: false)
            }
        case 1003:
            switch parkArea {
            case .amusement, .rideControl, .kitchen, .maintenance, .office: return createSwipeResult(accessible: true)
            }
        case 2001:
            switch parkArea {
            case .office: return createSwipeResult(accessible: true)
            default: return createSwipeResult(accessible: false)
            }
        case 2002:
            switch parkArea {
            case .kitchen, .maintenance: return createSwipeResult(accessible: true)
            default: return createSwipeResult(accessible: false)
            }
        default:
            return createSwipeResult(accessible: false, message: "Project # not recognized: \(projectNumber)")
        }
    }
    
    override func swipe(rideAccess: RideAccess, checkSwipeTime: Bool = true) -> SwipeResult {
        return createSwipeResult(accessible: false, checkSwipeTime: checkSwipeTime)
    }
    
    override func swipe(discountType: DiscountType) -> Float {
        switch discountType {
        case .food: return 0.0
        case .merchandise: return 0.0
        }
    }
}
