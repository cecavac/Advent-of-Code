//
//  Rave.swift
//  Advent16
//
//  Created by Dragan Cecavac on 12.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Rave {
    var programs = Array<Character>()
    let originalState: String

    init() {
        let start: Character = "a"
        let end: Character = "p"

        for i in start.asciiValue!...end.asciiValue! {
            programs.append(Character(UnicodeScalar(i)))
        }

        originalState = String(programs)
    }

    private func swap(indexA: Int, indexB: Int) {
        let tmp = programs[indexA]
        programs[indexA] = programs[indexB]
        programs[indexB] = tmp
    }

    @discardableResult
    public func dance(moves input: String) -> String {
        let elements = input.split(separator: ",")
        for element in elements {
            let command = element.prefix(1)
            let instructions = element.suffix(element.count - 1)

            switch command {
            case "s":
                let spin = Int(instructions)!

                for _ in 0..<spin {
                    let tmp = programs.removeLast()
                    programs.insert(tmp, at: 0)
                }

            case "x":
                let subelements = instructions.split(separator: "/")
                let indexA = Int(subelements[0])!
                let indexB = Int(subelements[1])!

                swap(indexA: indexA, indexB: indexB)
            case "p":
                var indexA = -1
                var indexB = -1

                let subelements = instructions.split(separator: "/")
                let swapA = String(subelements[0])
                let swapB = String(subelements[1])

                for i in 0..<programs.count {
                    if String(programs[i]) == swapA {
                        indexA = i
                    }

                    if String(programs[i]) == swapB {
                        indexB = i
                    }
                }

                swap(indexA: indexA, indexB: indexB)
            default:
                print("Bad element \(element)")
            }
        }

        return String(programs)
    }

    private func dancesUntilReset(moves: String) -> Int {
        // Already did one dance cycle
        var count = 1

        while String(programs) != originalState {
            dance(moves: moves)
            count += 1
        }

        return count
    }

    public func stateAfter(cycles: Int, moves: String) -> String{
        let repeatingPeriod = dancesUntilReset(moves: moves)
        let remainingCycles = cycles % repeatingPeriod
        for _ in 0..<remainingCycles {
            dance(moves: moves)
        }

        return String(programs)
    }
}
