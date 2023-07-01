//
//  Disc.swift
//  Advent15
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct Disc {
    var position: Int
    let positions: Int

    mutating func nextPosition() {
        position = (position + 1) % positions
    }
}
