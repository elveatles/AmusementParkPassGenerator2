//
//  Test.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A place to put all tests
struct Test {
    /// Run all tests
    func test() {
        testGuestPass()
        testVIPGuestPass()
        testFreeChildGuestPass()
        testHourlyEmployeeFoodServicesPass()
        testHourlyEmployeeRideServicesPass()
        testHourlyEmployeeMaintenancePass()
        testManagerPass()
        testIsBirthday()
        testSwipeTooSoon()
    }
    
    /**
     Print a description for a test section to separate the different tests from each other.
     
     - Parameter description: The description of the type of pass that is going to be tested.
     */
    func printTestPass(description: String) {
        print("\n")
        print(description)
        print("==============================================")
    }
    
    /// Test GuestPass access and discounts
    func testGuestPass() {
        printTestPass(description: "Classic Guest")
        do {
            let entrant = try Entrant()
            let guestPass = try GuestPass(entrant: entrant)
            testPass(guestPass)
        }
        catch {
            print("GuestPass error. This should not happen! \(error)")
        }
    }
    
    /// Test VIP guest pass access and discounts
    func testVIPGuestPass() {
        printTestPass(description: "VIP Guest Pass")
        
        do {
            let entrant = try Entrant()
            let pass = try VIPGuestPass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error creating VIPGuestPass: \(error)")
        }
    }
    
    /// Test FreeChildGuestPass access and discounts
    func testFreeChildGuestPass() {
        printTestPass(description: "Free Child Guest Pass")
        
        // This should throw an error because entrant has no date of birth
        do {
            let anonymousEntrant = try Entrant()
            let _ = try FreeChildGuestPass(entrant: anonymousEntrant)
        } catch PassError.missingInformation {
            print("Expected PassError.missingInformation error creating FreeChildGuestPass.")
        } catch {
            print("Unexpected error creating FreeChildGuestPass (entrant has no date of birth): \(error)")
        }
        
        // This should throw an error because the entrant is too old
        let today = Calendar.current.startOfDay(for: Date())
        let dateOfBirthTooOld = Calendar.current.date(byAdding: .year, value: -5, to: today)!
        let dateOfBirthTooOldString = Entrant.dateFormatter.string(from: dateOfBirthTooOld)
        do {
            let entrantTooOld = try Entrant(dateOfBirth: dateOfBirthTooOldString)
            let _ = try FreeChildGuestPass(entrant: entrantTooOld)
        } catch PassError.wrongAge(let description) {
            print("Expected PassError.wrongAge error: \(description)")
        } catch {
            print("Unexpected error creating FreeChildGuestPass (entrant too old): \(error)")
        }
        
        var dateOfBirth = Calendar.current.date(byAdding: .year, value: -5, to: today)!
        dateOfBirth = Calendar.current.date(byAdding: .day, value: 1, to: dateOfBirth)!
        let dateOfBirthString = Entrant.dateFormatter.string(from: dateOfBirth)
        do {
            let entrant = try Entrant(dateOfBirth: dateOfBirthString)
            let childGuestPass = try FreeChildGuestPass(entrant: entrant)
            testPass(childGuestPass)
        } catch {
            print("Unexpected error creating FreeChildGuestPass.")
        }
    }
    
    /// Test Hourly Employee - Food Services access and discounts
    func testHourlyEmployeeFoodServicesPass() {
        printTestPass(description: "Hourly Employee - Food Services Pass")
        
        do {
            let anonymousEntrant = try Entrant()
            let _ = try HourlyEmployeeFoodServicesPass(entrant: anonymousEntrant)
        } catch PassError.missingInformation(let description) {
            print("Expected PassError.missingInformation error thrown when creating HourlyEmployeeFoodServicesPass: \(description)")
        } catch {
            print("Unexpected error trying to create HourlyEmployeeFoodServicesPass with anonymous employee. \(error)")
        }
        
        do {
            let entrant = try Entrant(firstName: "First", lastName: "Last", streetAddress: "Street Address", city: "City", state: "CA", zipCode: "90000")
            let pass = try HourlyEmployeeFoodServicesPass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error trying to create HourlyEmployeeFoodServicesPass: \(error)")
        }
    }
    
    /// Test Hourly Employee - Ride Services access and discounts
    func testHourlyEmployeeRideServicesPass() {
        printTestPass(description: "Hourly Employee - Ride Services Pass")
        
        do {
            let partialEntrant = try Entrant(firstName: "First", lastName: "Last")
            let _ = try HourlyEmployeeRideServicesPass(entrant: partialEntrant)
        } catch PassError.missingInformation(let description) {
            print("Expected PassError.missingInformation error when creating HourlyEmployeeRideServicesPass with partialEntrant: \(description)")
        } catch {
            print("Unexpected error creating HourlyEmployeeRideServicesPass with partialEntrant: \(error)")
        }
        
        do {
            let entrant = try Entrant(firstName: "First", lastName: "Last", streetAddress: "Street Address", city: "City", state: "CA", zipCode: "90000")
            let pass = try HourlyEmployeeRideServicesPass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error creating HourlyEmployeeRideServicesPass: \(error)")
        }
    }
    
    /// Test Hourly Employee - Maintenance access and discounts
    func testHourlyEmployeeMaintenancePass() {
        printTestPass(description: "Hourly Employee - Maintenance Pass")
        
        do {
            let partialEntrant = try Entrant(firstName: "First", lastName: "Last")
            let _ = try HourlyEmployeeMaintenancePass(entrant: partialEntrant)
        } catch PassError.missingInformation(let description) {
            print("Expected PassError.missingInformation error when creating HourlyEmployeeMaintenancePass with partialEntrant: \(description)")
        } catch {
            print("Unexpected error creating HourlyEmployeeMaintenancePass with partialEntrant: \(error)")
        }
        
        do {
            let entrant = try Entrant(firstName: "First", lastName: "Last", streetAddress: "Street Address", city: "City", state: "CA", zipCode: "90000")
            let pass = try HourlyEmployeeMaintenancePass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error creating HourlyEmployeeMaintenancePass: \(error)")
        }
    }
    
    /// Test Manager access and discounts
    func testManagerPass() {
        printTestPass(description: "Manager Pass")
        
        do {
            let partialEntrant = try Entrant(firstName: "First", lastName: "Last")
            let _ = try ManagerPass(entrant: partialEntrant)
        } catch PassError.missingInformation(let description) {
            print("Expected PassError.missingInformation error when creating ManagerPass with partialEntrant: \(description)")
        } catch {
            print("Unexpected error creating ManagerPass with partialEntrant: \(error)")
        }
        
        do {
            let entrant = try Entrant(firstName: "First", lastName: "Last", streetAddress: "Street Address", city: "City", state: "CA", zipCode: "90000")
            let pass = try ManagerPass(entrant: entrant)
            testPass(pass)
        } catch {
            print("Unexpected error creating ManagerPass: \(error)")
        }
    }
    
    /// Test if birthday check is working
    func testIsBirthday() {
        printTestPass(description: "Test Entrant Birthday")
        
        // Test isBirthday without date of birth
        do {
            let anonymousEntrant = try Entrant()
            if anonymousEntrant.isBirthday == nil {
                print("Expectedly could not check entrant's birthday without a date of birth.")
            } else {
                print("Unexpectedly got result from isBirthday even though entrant's date of birth was not provided.")
            }
        } catch {
            print("Unexpected error creating anonymousEntrant in testIsBirthday: \(error)")
        }
        
        // Test isBirthday when it is the entrant's birthday
        guard let birthdayDateOfBirth = Calendar.current.date(byAdding: .year, value: -1, to: Date()) else {
            print("Could not create birthdayDateOfBirth in testIsBirthday")
            return
        }
        
        let birthdayDateOfBirthString = Entrant.dateFormatter.string(from: birthdayDateOfBirth)
        do {
            let birthdayEntrant = try Entrant(dateOfBirth: birthdayDateOfBirthString)
            if let isBirthday = birthdayEntrant.isBirthday {
                if isBirthday {
                    print("Expectedly isBirthday is true for birthdayEntrant")
                } else {
                    print("Unexpectedly isBirthday is false for birthdayEntrant")
                }
            } else {
                print("Unexpectedly guestPass.isBirthday is nil for birthdayEntrant")
            }
        } catch {
            print("Unexpected error creating birthdayEntrant in testIsBirthday: \(error)")
        }
        
        // Test swipe message for birthday entrant
        do {
            let birthdayEntrant = try Entrant(dateOfBirth: birthdayDateOfBirthString)
            let guestPass = try GuestPass(entrant: birthdayEntrant)
            var swipeResult = guestPass.swipe(parkArea: .amusement)
            print("birthday swipeResult for amusement area: \(swipeResult)")
            swipeResult = guestPass.swipe(parkArea: .office)
            print("birthday swipeResult for office area: \(swipeResult)")
        } catch {
            print("Unexpected error creating GuestPass for birthdayEntrant: \(error)")
        }
        
        // Test isBirthday for non-birthday entrant
        guard let nonBirthdayDateOfBirth = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            print("Could not create nonBirthdayDateOfBirth in testIsBirthday")
            return
        }
        let nonBirthdayDateOfBirthString = Entrant.dateFormatter.string(from: nonBirthdayDateOfBirth)
        
        do {
            let nonBirthdayEntrant = try Entrant(dateOfBirth: nonBirthdayDateOfBirthString)
            if let isBirthday = nonBirthdayEntrant.isBirthday {
                if isBirthday {
                    print("Unexpectedly isBirthday is true for nonBirthdayEntrant")
                } else {
                    print("Expectedly isBirthday is false for nonBirthdayEntrant")
                }
            } else {
                print("Unexpectedly guestPass.isBirthday is nil for nonBirthdayEntrant")
            }
        } catch {
            print("Unexpected error creating nonBirthdayEntrant in testIsBirthday: \(error)")
        }
        
        // Test swipe message for non-birthday entrant
        do {
            let nonBirthdayEntrant = try Entrant(dateOfBirth: nonBirthdayDateOfBirthString)
            let guestPass = try GuestPass(entrant: nonBirthdayEntrant)
            var swipeResult = guestPass.swipe(parkArea: .amusement)
            print("non-birthday swipeResult for amusement area: \(swipeResult)")
            swipeResult = guestPass.swipe(parkArea: .office)
            print("non-birthday swipeResult for office area: \(swipeResult)")
        } catch {
            print("Unexpected error creating GuestPass for birthdayEntrant: \(error)")
        }
    }
    
    /// Test multiple swipes that happen to soon
    func testSwipeTooSoon() {
        printTestPass(description: "Swipe Too Soon")
        
        do {
            let entrant = try Entrant()
            let pass = try GuestPass(entrant: entrant)
            let _ = pass.swipe(rideAccess: .all)
            var swipeResult = pass.swipe(rideAccess: .all)
            print("Swipe too soon result: \(swipeResult)")
            
            let seconds = -TimeInterval(Pass.secondsBetweenSwipes) - 1.0
            pass.lastSwipeTime = Date(timeIntervalSinceNow: seconds)
            swipeResult = pass.swipe(rideAccess: .all)
            print("Swipe result right after time limit: \(swipeResult)")
        } catch {
            print("Unexpected error creating GuestPass in testSwipeTooSoon")
        }
    }
    
    /**
     Test access and discounts for a pass.
     
     - Parameter pass: The pass to test.
     */
    func testPass(_ pass: Pass) {
        print("Park Area")
        print("----------------------------------------------")
        var parkAreaResult = pass.swipe(parkArea: .amusement)
        print("Amusement Park: \(parkAreaResult)")
        parkAreaResult = pass.swipe(parkArea: .kitchen)
        print("Kitchen: \(parkAreaResult)")
        parkAreaResult = pass.swipe(parkArea: .maintenance)
        print("Maintenance: \(parkAreaResult)")
        parkAreaResult = pass.swipe(parkArea: .rideControl)
        print("Ride Control: \(parkAreaResult)")
        parkAreaResult = pass.swipe(parkArea: .office)
        print("Office: \(parkAreaResult)")
        
        print("Ride Access")
        print("----------------------------------------------")
        var rideAccessResult = pass.swipe(rideAccess: .all)
        print("All Rides: \(rideAccessResult)")
        pass.lastSwipeTime = nil // Ignore the last swipe time rule for testing
        rideAccessResult = pass.swipe(rideAccess: .skipLines)
        print("Skip lines: \(rideAccessResult)")
        
        print("Discounts")
        print("----------------------------------------------")
        var discountResult = pass.swipe(discountType: .food)
        print("Food: \(discountResult)")
        discountResult = pass.swipe(discountType: .merchandise)
        print("Merchandise: \(discountResult)")
    }
}
