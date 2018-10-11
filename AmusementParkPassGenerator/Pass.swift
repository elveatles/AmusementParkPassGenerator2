//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/**
 Root class for all Pass types.
 Represents a pass that can be swiped to access different areas of the park,
 rides that can be accessed, and discounts for food or merchandis.
*/
class Pass: Swipeable {
    /// The number of seconds an entrant has to wait before they can swipe again
    static let secondsBetweenSwipes = 5
    
    /// The entrant this card was assigned to
    let entrant: Entrant
    /// The last time the entrant swiped
    var lastSwipeTime: Date?
    
    /// Check if a swipe is too soon since the last swipe
    var isSwipeTooSoon: Bool {
        guard let lastTime = lastSwipeTime else {
            return false
        }
        
        let swipeSeconds = Int(Date().timeIntervalSince(lastTime))
        return swipeSeconds < Pass.secondsBetweenSwipes
    }
    
    /**
     Create a pass that stores entrant information.
     This class does not throw any errors, but inherited classes do.
     
     - Parameter entrant: The entrant (person) to assign to this pass.
    */
    init(entrant: Entrant) throws {
        self.entrant = entrant
    }
    
    /**
     Swipe the card to get into a certain area of the park.
     
     - Parameter parkArea: The area of the park to access.
     - Returns: Whether the swipe allows access and a message to show the user. This implementation is always unsuccessful because it was meant to be overridden in a subclass.
    */
    func swipe(parkArea: ParkArea) -> SwipeResult {
        return SwipeResult(success: false, message: "Swipe function must be overridden in an inherited class.")
    }
    
    /**
     Swipe the card to access a ride.
     
     - Parameter rideAccess: The type of ride access the swiper wants.
     - Returns: Whether the swipe allows access and a message to show the user. This implementation is always unsuccessful because it was meant to be overridden in a subclass.
    */
    func swipe(rideAccess: RideAccess) -> SwipeResult {
        return SwipeResult(success: false, message: "Swipe function must be overridden in an inherited class.")
    }
    
    /**
     Swipe the card at a place that offers discounts.
     
     - Parameter discountType: The type of discount the swiper should get.
     - Returns: The discount from 0.0 - 1.0.
    */
    func swipe(discountType: DiscountType) -> Float {
        return 0.0
    }
    
    /**
     Get the message for the swipe result.
     
     - Parameter success: true if the swip was successful.
     - Returns: The message for the swipe result.
    */
    func getSwipeMessage(success: Bool) -> String {
        if let isBirthday = entrant.isBirthday, isBirthday {
            if success {
                return "Welcome and Happy Birthday!"
            } else {
                return "It may be your birthday, but you're still not allowed in this area."
            }
        }
        
        if success {
            return "Welcome!"
        } else {
            return "Sorry, you're not allowed in here."
        }
    }
    
    /**
     Create a SwipeResult.
     
     This customizes the SwipeResult message if it's the entrant's birthday.
     
     - Parameter accessible: true if swipe happened in an accessible area.
     - Parameter checkSwipeTime: If true, the last swipe time will be checked to make sure the entrant hasn't swiped again too soon. Also updates the last swipe time.
     - Returns: The swipe result.
    */
    func createSwipeResult(accessible: Bool, checkSwipeTime: Bool = false) -> SwipeResult {
        if checkSwipeTime {
            if isSwipeTooSoon {
                lastSwipeTime = Date()
                return SwipeResult(success: false, message: "You swiped too soon since your last swipe. You'll have to wait some time.")
            }
            
            lastSwipeTime = Date()
        }
        
        let message = getSwipeMessage(success: accessible)
        return SwipeResult(success: accessible, message: message)
    }
}
