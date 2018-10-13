//
//  SeasonGuestPass.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/12/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

class SeasonGuestPass: GuestPass {
    override class var requiredEntrantInfo: Set<EntrantInfo> {
        return [.firstName, .lastName, .streetAddress, .city, .state, .zipCode]
    }
}
