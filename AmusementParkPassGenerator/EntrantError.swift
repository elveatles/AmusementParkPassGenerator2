//
//  FieldError.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/16/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Error related to Entrants
enum EntrantError: Error {
    /// Some required fields are missing
    case missingInformation(fields: Set<EntrantInfo>)
    /// Some fields are too long
    case exceedsMaxLength(fields: Set<EntrantInfo>)
    /// Some fields are not in a valid format
    case invalidFormat(fields: Set<EntrantInfo>)
    /// Entrant is too old or too young
    case wrongAge(description: String)
    /// An invalid project number is used
    case invalidProjectNumber(value: Int)
    /// An invalid company is used
    case invalidCompany(value: String)
}
