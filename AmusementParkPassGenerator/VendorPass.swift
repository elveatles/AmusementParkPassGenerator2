//
//  VendorPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Pass for a vendor entrant
class VendorPass: Pass {
    override class var typeDisplayName: String {
        return "Vendor Pass"
    }
    
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        // date of visit is automatically filled in
        return [.firstName, .lastName, .company, .dateOfBirth]
    }
    
    override func swipe(parkArea: ParkArea) -> SwipeResult {
        guard let company = entrant.company else {
            print("VendorPass.swipe(parkArea:): entrant.company does not exist.")
            return createSwipeResult(accessible: false)
        }
        
        switch company {
        case "Acme":
            switch parkArea {
            case .kitchen: return createSwipeResult(accessible: true)
            default: return createSwipeResult(accessible: false)
            }
        case "Orkin":
            switch parkArea {
            case .amusement, .rideControl, .kitchen: return createSwipeResult(accessible: true)
            default: return createSwipeResult(accessible: false)
            }
        case "Fedex":
            switch parkArea {
            case .maintenance, .office: return createSwipeResult(accessible: true)
            default: return createSwipeResult(accessible: false)
            }
        case "NW Electrical":
            switch parkArea {
            case .amusement, .rideControl, .kitchen, .maintenance, .office: return createSwipeResult(accessible: true)
            }
        default:
            return createSwipeResult(accessible: false, message: "Company not recognized.")
        }
    }
    
    override func swipe(rideAccess: RideAccess, checkSwipeTime: Bool) -> SwipeResult {
        return createSwipeResult(accessible: false, checkSwipeTime: checkSwipeTime)
    }
}
