//
//  Octopus.swift
//  Advent11
//
//  Created by Dragan Cecavac on 11.12.21.
//

import Foundation

class Octopus {
    private var flashed = false
    private var energy: Int
    private var neighbors = Array<Octopus>()

    init (_ base: Int) {
        energy = base
    }

    func addNeighbor(neighbor: Octopus) {
        neighbors.append(neighbor)
    }

    func tick() {
        if !flashed {
            energy += 1
            if energy == 10 {
                flashed = true
                energy = 0
                for neighbor in neighbors {
                    neighbor.tick()
                }
            }
        }
    }

    func resetFlash() -> Bool {
        let result = flashed
        flashed = false
        return result
    }
}
