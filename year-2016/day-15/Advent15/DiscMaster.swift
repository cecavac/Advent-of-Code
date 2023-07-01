//
//  DiscMaster.swift
//  Advent15
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class DiscMaster {
    var discs: [Disc] = []

    init(_ input: String, include additionalDisc: Disc?) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let elements = line.split(separator: " ")
            let positions = Int(elements[3])!

            let positionDirty = elements[11]
            let positionClean = positionDirty.prefix(positionDirty.count - 1)
            let position = Int(positionClean)!

            discs.append(Disc(position: position, positions: positions))
        }

        if additionalDisc != nil {
            discs.append(additionalDisc!)
        }

        prerotate()
    }

    func prerotate() {
        for i in 0..<discs.count {
            for _ in 0...i {
                discs[i].nextPosition()
            }
        }
    }

    func isAligned() -> Bool {
        for disc in discs {
            if disc.position != 0 {
                return false
            }
        }

        return true
    }

    func alignmentTime() -> Int {
        var time = 0

        while !isAligned() {
            for i in 0..<discs.count {
                discs[i].nextPosition()
            }

            time += 1
        }

        return time
    }
}
