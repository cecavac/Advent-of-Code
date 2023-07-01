//
//  Number.swift
//  Advent20
//
//  Created by Dragan Cecavac on 20.12.22.
//

import Foundation

struct Number: Equatable {
    let value: Int
    let id: Int

    static func ==(lhs: Number, rhs: Number) -> Bool {
        return lhs.id == rhs.id
    }
}
