//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Describes someone who can enter the park -- a guest, employee, manager, etc.
struct Entrant {
    static let dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
        return result
    }()
    
    let dateOfBirth: Date?
    let ssn: (Int, Int, Int)?
    let projectNumber: Int?
    let firstName: String?
    let lastName: String?
    let company: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: Int?
    let dateOfVisit = Date()
    
    /**
     Get a date from a string in MM/dd/yyyy format.
     
     - Parameter: date: The date string to convert.
     - Returns: The date converted from the string. nil if the string was not formatted properly.
    */
    static func dateFrom(_ date: String) -> Date? {
        let dateNoSpaces = date.replacingOccurrences(of: " ", with: "")
        let result = dateFormatter.date(from: dateNoSpaces)
        return result
    }
    
    /**
     Get a social security number as a tuple from a string.
     
     - Parameter string: The social security number as a string to convert.
     - Returns: The social security number converted to a tuple of Ints.
    */
    static func ssnFrom(_ string: String) -> (Int, Int, Int)? {
        let stringNoSpaces = string.replacingOccurrences(of: " ", with: "")
        let components = stringNoSpaces.components(separatedBy: "-")
        
        guard components.count == 3 else { return nil }
        
        var intComponents = components.map { Int($0) }
        
        guard !intComponents.contains(nil) else { return nil }
        
        // Okay to force unwrap because a check for any nils is right above
        return (intComponents[0]!, intComponents[1]!, intComponents[2]!)
    }
    
    /// Check if it's the entrant's birthday. nil if the entrant did not provide their date of birth
    var isBirthday: Bool? {
        guard let dob = dateOfBirth else {
            return nil
        }
        
        let todayMonthDay = Calendar.current.dateComponents([.month, .day], from: Date())
        let dateOfBirthMonthDay = Calendar.current.dateComponents([.month, .day], from: dob)
        return todayMonthDay == dateOfBirthMonthDay
    }
    
    init(
        dateOfBirth: Date? = nil,
        ssn: (Int, Int, Int)? = nil,
        projectNumber: Int? = nil,
        company: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        streetAddress: String? = nil,
        city: String? = nil,
        state: String? = nil,
        zipCode: Int? = nil) {
        self.dateOfBirth = dateOfBirth
        self.ssn = ssn
        self.projectNumber = projectNumber
        self.company = company
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}
