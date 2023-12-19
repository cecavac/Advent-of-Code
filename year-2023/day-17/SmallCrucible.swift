//
//  SmallCrucible.swift
//  day-17
//
//  Created by Dragan Cecavac on 17.12.23.
//

import Foundation

class SmallCrucible: Crucible {
    init(_ input: String) {
        super.init(input, hashBase: 3)
    }
}
