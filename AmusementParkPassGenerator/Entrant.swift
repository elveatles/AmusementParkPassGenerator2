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
