//
//  ElfCrowd.swift
//  Advent23
//
//  Created by Dragan Cecavac on 23.12.22.
//

import Foundation

class ElfCrowd {
    var elves = [Elf]()

    init (_ input: String) {
        let lines = input.split(separator: "\n")
        for i in 0..<lines.count {
            let positions = Array(lines[i])
            for j in 0..<positions.count {
                if positions[j] == "#" {
                    let elf = Elf(i: i, j: j)
                    elves.append(elf)
                }
            }
        }
    }

    func mapElves() -> Set<String> {
        var result = Set<String>()

        for elf in elves {
            result.insert(elf.position())
        }

        return result
    }

    func move(cycles: Int?) -> Int {
        var maxCycles = Int.max
        if cycles != nil {
            maxCycles = cycles!
        }

        for i in 0..<maxCycles {
            let elfLocations = mapElves()
            var wishes = [String:Int]()

            for elf in elves {
                if let wish = elf.ponder(elves: elfLocations, round: i) {
                    if wishes[wish] == nil {
                        wishes[wish] = 1
                    } else {
                        wishes[wish] = wishes[wish]! + 1
                    }
                }
            }

            if wishes.count == 0 {
                return i + 1
            }

            for elf in elves {
                if let wish = elf.proposal() {
                    if wishes[wish]! == 1 {
                        elf.approve()
                    } else {
                        elf.deny()
                    }
                }
            }

//            show()
        }

        return 0
    }

    func groundCovered() -> Int {
        var maxI = Int.min
        var minI = Int.max
        var maxJ = Int.min
        var minJ = Int.max

        for elf in elves {
            maxI = max(maxI, elf.positionI)
            minI = min(minI, elf.positionI)
            maxJ = max(maxJ, elf.positionJ)
            minJ = min(minJ, elf.positionJ)
        }

        let height = maxI - minI + 1
        let width = maxJ - minJ + 1
        return height * width - elves.count
    }

    func show() {
        var maxI = Int.min
        var minI = Int.max
        var maxJ = Int.min
        var minJ = Int.max

        for elf in elves {
            maxI = max(maxI, elf.positionI)
            minI = min(minI, elf.positionI)
            maxJ = max(maxJ, elf.positionJ)
            minJ = min(minJ, elf.positionJ)
        }

        for i in minI...maxI {
            var line = ""
            for j in minJ...maxJ {
                var found = false
                for elf in elves {
                    if elf.positionI == i && elf.positionJ == j {
                        found = true
                        break
                    }
                }
                if found {
                    line += "#"
                } else {
                    line += "."
                }
            }
            print(line)
        }
        print()
    }
}
