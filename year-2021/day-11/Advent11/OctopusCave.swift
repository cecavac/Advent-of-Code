//
//  OctopusCave.swift
//  Advent11
//
//  Created by Dragan Cecavac on 11.12.21.
//

import Foundation

class OctopusCave {
    var octopuses = [[Octopus]]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for i in lines.indices {
            let energyRow = Array(String(lines[i]))
            var octopusRow = [Octopus]()
            for j in energyRow.indices {
                let octopus = Octopus(Int("\(energyRow[j])")!)
                octopusRow.append(octopus)
            }
            octopuses.append(octopusRow)
        }

        for i in 0..<10 {
            for j in 0..<10 {
                for iOffset in (i - 1)...(i + 1) {
                    for jOffset in (j - 1)...(j + 1) {
                        if iOffset >= 0 && iOffset < 10 &&
                            jOffset >= 0 && jOffset < 10 &&
                            !(i == iOffset && j == jOffset) {
                            octopuses[i][j].addNeighbor(neighbor: octopuses[iOffset][jOffset])
                        }
                    }
                }
            }
        }
    }

    func tick() -> Int {
        var result = 0
        for i in 0..<10 {
            for j in 0..<10 {
                octopuses[i][j].tick()
            }
        }

        for i in 0..<10 {
            for j in 0..<10 {
                if octopuses[i][j].resetFlash() {
                    result += 1
                }
            }
        }

        return result
    }

    func tick(count: Int) -> Int {
        var result = 0
        for _ in 0..<count {
            result += tick()
        }
        return result
    }

    func bigFlash() -> Int {
        var result = 0
        while true {
            result += 1
            let flashes = tick()
            if flashes == 100 {
                return result
            }
        }
    }
}
