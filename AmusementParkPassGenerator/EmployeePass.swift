//
//  EmployeePass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/5/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// An employee park pass. Should be subclassed for specific employee types.
class EmployeePass: Pass {
    /**
     Create the pass.
     
     - Parameter entrant: The entrant information.
     - Throws: `PassError.missingInformation`
                if the entrant did not provide all the necessary information.
    */
    override init(entrant: Entrant) throws {
        try super.init(entrant: entrant)
        
        var missingInformation: [String] = []
        
        if entrant.firstName == nil {
            missingInformation.append("first name")
        }
        
        if entrant.lastName == nil {
            missingInformation.append("last name")
        }
        
        if entrant.streetAddress == nil {
            missingInformation.append("street address")
        }
        
        if entrant.city == nil {
            missingInformation.append("city")
        }
        
        if entrant.state == nil {
            missingInformation.append("state")
        }
        
        if entrant.zipCode == nil {
            missingInformation.append("zip code")
        }
        
        guard missingInformation.isEmpty else {
            let missing = missingInformation.joined(separator: ", ")
            let desc = "Entrant is missing information: \(missing)"
            throw PassError.missingInformation(description: desc)
        }
    }
    
    override func swipe(rideAccess: RideAccess) -> SwipeResult {
        switch rideAccess {
        case .all: return createSwipeResult(accessible: true, checkSwipeTime: true)
        default: return createSwipeResult(accessible: false, checkSwipeTime: true)
        }
    }
    
    override func swipe(discountType: DiscountType) -> Float {
        switch discountType {
        case .food: return 0.15
        case .merchandise: return 0.25
        }
    }
}
