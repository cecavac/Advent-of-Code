//
//  Validator.swift
//  Advent4
//
//  Created by Dragan Cecavac on 02.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Validator {
    private(set) var result1 = 0
    private(set) var result2 = 0

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            let room = Room(String(line))
            if room.isValid {
                result1 += room.id
            }

            if room.isNorthPoleRelated(){
                result2 = room.id
            }
        }
    }
}
