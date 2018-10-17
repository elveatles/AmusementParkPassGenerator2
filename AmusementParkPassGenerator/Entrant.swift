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
    
    static let fistNameMaxLength = 100
    static let lastNameMaxLength = 100
    static let companyMaxLength = 100
    static let streetAddressMaxLength = 100
    static let cityMaxLength = 100
    static let stateLength = 2
    static let projectNumberLength = 4
    static let zipCodeLengthFirst = 5
    static let zipCodeLengthSecond = 4
    
    let subtype: EntrantSubtype
    let dateOfBirth: Date?
    let ssn: (Int, Int, Int)?
    let projectNumber: Int?
    let firstName: String?
    let lastName: String?
    let company: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: (Int, Int?)?
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
    
    /**
     Get a project number from a string.
     
     - Parameter string: The project number as a string.
     - Returns: The project number as an Int. nil if not formatted correctly.
    */
    static func projectNumberFrom(_ string: String) -> Int? {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make sure the number has the correct number of digits
        guard trimmed.count == Entrant.projectNumberLength else { return nil }
        
        return Int(trimmed)
    }
    
    /**
     Check the zip code format and convert a string into two Ints.
     
     - Parameter string: The zip code as a string. Can be ##### or #####-####.
     - Returns: The zip code as Ints.
    */
    static func zipCodeFrom(_ string: String) -> (Int, Int?)? {
        // Check for cases where the postal code uses a dash such as 90000-1000
        let components = string.components(separatedBy: "-")
        
        // At least one component should be present
        guard let firstComponent = components.first else { return nil }
        
        let firstTrimmed  = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make sure the postal code is the right length
        guard firstTrimmed.count == Entrant.zipCodeLengthFirst else { return nil }
        
        // The first number in the zip code should be present and be a number
        guard let firstInt = Int(firstTrimmed) else { return nil }
        
        // Check if there is a second part to the postal code
        guard components.count > 1 else { return (firstInt, nil) }
        
        let secondTrimmed = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make sure the second part of the postal code has the correct number of digits
        guard secondTrimmed.count == Entrant.zipCodeLengthSecond else { return (firstInt, nil) }
        
        return (firstInt, Int(secondTrimmed))
    }
    
    /// The full name of the entrant using first name and last name
    var fullName: String? {
        guard let first = firstName, let last = lastName else {
            return nil
        }
        
        return "\(first) \(last)"
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
    
    /**
     Initializer that's good for taking input from text fields and checking that they are formatted
     correctly and none of the fields are too long.
     
     - Throws: `EntrantError.invalidFormat`
                if any non-nil fields are formatted incorrectly.
                `EntrantError.exceedsMaxLength`
                if any of the non-nil fields are too long.
    */
    init(
        subtype: EntrantSubtype,
        dateOfBirth: String? = nil,
        ssn: String? = nil,
        projectNumber: String? = nil,
        company: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        streetAddress: String? = nil,
        city: String? = nil,
        state: String? = nil,
        zipCode: String? = nil) throws {
        
        self.subtype = subtype
        
        // Check for missing fields
        let requiredInfo = subtype.requiredEntrantInfo
        var missingInformation = Set<EntrantInfo>()
        
        if requiredInfo.contains(.dateOfBirth) && String.isNilOrNothing(dateOfBirth) {
            missingInformation.insert(.dateOfBirth)
        }
        
        if requiredInfo.contains(.ssn) && String.isNilOrNothing(ssn) {
            missingInformation.insert(.ssn)
        }
        
        if requiredInfo.contains(.projectNumber) && String.isNilOrNothing(projectNumber) {
            missingInformation.insert(.projectNumber)
        }
        
        if requiredInfo.contains(.firstName) && String.isNilOrNothing(firstName) {
            missingInformation.insert(.firstName)
        }
        
        if requiredInfo.contains(.lastName) && String.isNilOrNothing(lastName) {
            missingInformation.insert(.lastName)
        }
        
        if requiredInfo.contains(.company) && String.isNilOrNothing(company) {
            missingInformation.insert(.company)
        }
        
        if requiredInfo.contains(.streetAddress) && String.isNilOrNothing(streetAddress) {
            missingInformation.insert(.streetAddress)
        }
        
        if requiredInfo.contains(.city) && String.isNilOrNothing(city) {
            missingInformation.insert(.city)
        }
        
        if requiredInfo.contains(.state) && String.isNilOrNothing(state) {
            missingInformation.insert(.state)
        }
        
        if requiredInfo.contains(.zipCode) && String.isNilOrNothing(zipCode) {
            missingInformation.insert(.zipCode)
        }
        
        guard missingInformation.isEmpty else {
            throw EntrantError.missingInformation(fields: missingInformation)
        }
        
        // Check for fields being too long
        var tooLongFields = Set<EntrantInfo>()
        if let comp = company, comp.count > Entrant.companyMaxLength {
            tooLongFields.insert(.company)
        }
        
        if let first = firstName, first.count > Entrant.fistNameMaxLength {
            tooLongFields.insert(.firstName)
        }
        
        if let last = lastName, last.count > Entrant.lastNameMaxLength {
            tooLongFields.insert(.lastName)
        }
        
        if let street = streetAddress, street.count > Entrant.streetAddressMaxLength {
            tooLongFields.insert(.streetAddress)
        }
        
        if let cit = city, cit.count > Entrant.cityMaxLength {
            tooLongFields.insert(.city)
        }
        
        if !tooLongFields.isEmpty {
            throw EntrantError.exceedsMaxLength(fields: tooLongFields)
        }
        
        // Check for fields that are formatted incorrectly
        var badFormatFields = Set<EntrantInfo>()
        
        // Date of birth
        if let dob = dateOfBirth,
            !dob.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.dateOfBirth = Entrant.dateFrom(dob)
            
            if self.dateOfBirth == nil {
                badFormatFields.insert(.dateOfBirth)
            }
        } else {
            self.dateOfBirth = nil
        }
        
        // SSN
        if let ssnValue = ssn,
            !ssnValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.ssn = Entrant.ssnFrom(ssnValue)
            
            if self.ssn == nil {
                badFormatFields.insert(.ssn)
            }
        } else {
            self.ssn = nil
        }
        
        // Project #
        if let projNum = projectNumber,
            !projNum.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.projectNumber = Entrant.projectNumberFrom(projNum)
            
            if self.projectNumber == nil {
                badFormatFields.insert(.projectNumber)
            }
        } else {
            self.projectNumber = nil
        }
        
        self.company = company
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        
        // State
        if let st = state {
            let trimmed = st.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.count != Entrant.stateLength {
                badFormatFields.insert(.state)
            }
            
            self.state = trimmed
        } else {
            self.state = nil
        }
        
        // ZIP
        if let zip = zipCode,
            !zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.zipCode = Entrant.zipCodeFrom(zip)
            
            if self.zipCode == nil {
                badFormatFields.insert(.zipCode)
            }
        } else {
            self.zipCode = nil
        }
        
        if !badFormatFields.isEmpty {
            throw EntrantError.invalidFormat(fields: badFormatFields)
        }
        
        // Check age
        if let dob = self.dateOfBirth {
            let now = Date()
            let age = Calendar.current.dateComponents([.year], from: dob, to: now)
            
            if subtype == .childGuest {
                guard age.year ?? 100 < FreeChildGuestPass.ageCutoff else {
                    throw EntrantError.wrongAge(description: "Entrant must be younger than \(FreeChildGuestPass.ageCutoff). age: \(age)")
                }
            } else if subtype == .seniorGuest {
                // Nothing in the the Business Rules Matrix about specific age
                guard age.year ?? 0 >= SeniorGuestPass.ageCutoff else {
                    throw EntrantError.wrongAge(description: "Entrant must be \(SeniorGuestPass.ageCutoff) or older. age: \(age)")
                }
            }
        }
    }
}
