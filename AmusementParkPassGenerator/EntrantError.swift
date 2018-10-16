//
//  FieldError.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/16/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

/// Error related to Entrants
enum EntrantError: Error {
    /// A field is not in a valid format
    case invalidFormat(fields: Set<EntrantInfo>)
    case exceedsMaxLength(fields: Set<EntrantInfo>)
}
