//
//  Elf.swift
//  Advent23
//
//  Created by Dragan Cecavac on 23.12.22.
//

import Foundation

class Elf {
    var positionI: Int
    var positionJ: Int
    var proposedI: Int? = nil
    var proposedJ: Int? = nil

    init(i: Int, j: Int) {
        positionI = i
        positionJ = j
    }

    func proposal() -> String? {
        if proposedI != nil && proposedJ != nil {
            return "\(proposedI!)#\(proposedJ!)"
        } else {
            return nil
        }
    }

    func position() -> String {
        return "\(positionI)#\(positionJ)"
    }

    func approve() {
        positionI = proposedI!
        positionJ = proposedJ!
        proposedI = nil
        proposedJ = nil
    }

    func deny() {
        proposedI = nil
        proposedJ = nil
    }

    func shouldMove(elves: Set<String>) -> Bool {
        for i in -1...1 {
            for j in -1...1 {
                if i == 0 && j == 0 {
                    continue
                }

                let location = "\(positionI + i)#\(positionJ + j)"
                if elves.contains(location) {
                    return true
                }
            }
        }

        return false
    }

    func moveNorth(elves: Set<String>) -> Bool {
        let location1 = "\(positionI - 1)#\(positionJ - 1)"
        let location2 = "\(positionI - 1)#\(positionJ + 0)"
        let location3 = "\(positionI - 1)#\(positionJ + 1)"

        if !elves.contains(location1) &&
            !elves.contains(location2) &&
            !elves.contains(location3) {
            proposedI = positionI - 1
            proposedJ = positionJ
            return true
        } else {
            return false
        }
    }

    func moveSouth(elves: Set<String>) -> Bool {
        let location1 = "\(positionI + 1)#\(positionJ - 1)"
        let location2 = "\(positionI + 1)#\(positionJ + 0)"
        let location3 = "\(positionI + 1)#\(positionJ + 1)"

        if !elves.contains(location1) &&
            !elves.contains(location2) &&
            !elves.contains(location3) {
            proposedI = positionI + 1
            proposedJ = positionJ
            return true
        } else {
            return false
        }
    }

    func moveWest(elves: Set<String>) -> Bool {
        let location1 = "\(positionI - 1)#\(positionJ - 1)"
        let location2 = "\(positionI + 0)#\(positionJ - 1)"
        let location3 = "\(positionI + 1)#\(positionJ - 1)"

        if !elves.contains(location1) &&
            !elves.contains(location2) &&
            !elves.contains(location3) {
            proposedI = positionI
            proposedJ = positionJ - 1
            return true
        } else {
            return false
        }
    }

    func moveEast(elves: Set<String>) -> Bool {
        let location1 = "\(positionI - 1)#\(positionJ + 1)"
        let location2 = "\(positionI + 0)#\(positionJ + 1)"
        let location3 = "\(positionI + 1)#\(positionJ + 1)"

        if !elves.contains(location1) &&
            !elves.contains(location2) &&
            !elves.contains(location3) {
            proposedI = positionI
            proposedJ = positionJ + 1
            return true
        } else {
            return false
        }
    }

    func ponder(elves: Set<String>, round: Int) -> String? {
        if shouldMove(elves: elves) {
            switch round % 4 {
            case 0:
                if moveNorth(elves: elves) ||
                    moveSouth(elves: elves) ||
                    moveWest(elves: elves) ||
                    moveEast(elves: elves) {
                    return proposal()
                }
            case 1:
                if moveSouth(elves: elves) ||
                    moveWest(elves: elves) ||
                    moveEast(elves: elves) ||
                    moveNorth(elves: elves) {
                    return proposal()
                }
            case 2:
                if moveWest(elves: elves) ||
                    moveEast(elves: elves) ||
                    moveNorth(elves: elves) ||
                    moveSouth(elves: elves) {
                    return proposal()
                }
            case 3:
                if moveEast(elves: elves) ||
                    moveNorth(elves: elves) ||
                    moveSouth(elves: elves) ||
                    moveWest(elves: elves) {
                    return proposal()
                }
            default:
                print("Impossible move direction: \(round % 4)")
            }
        }

        return nil
    }
}
