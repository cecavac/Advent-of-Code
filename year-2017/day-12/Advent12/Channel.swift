//
//  Channel.swift
//  Advent12
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Channel {
    struct Program {
        let id: Int
        var pipe = Set<Int>()
    }

    var programs = Array<Program>()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var cleanLine = ""

            for char in line {
                if char != "," {
                    cleanLine.append(char)
                }
            }

            let elements = cleanLine.split(separator: " ")
            var program = Program(id: Int(elements[0])!)
            for i in 2..<elements.count {
                program.pipe.insert(Int(elements[i])!)
            }

            programs.append(program)
        }
    }

    public func getFirstGroupElements(removeElements: Bool) -> Int {
        var reachable = Set<Int>()
        var changed: Bool

        if programs.count == 0 {
            return 0
        }

        let firstGroupElement = programs[0]
        reachable.insert(firstGroupElement.id)
        for subProgram in firstGroupElement.pipe {
            reachable.insert(subProgram)
        }

        repeat {
            changed = false

            for program in programs {
                if reachable.contains(program.id) {
                    continue
                }

                var isReachable = false

                for subProgram in program.pipe {
                    if reachable.contains(subProgram) {
                        isReachable = true
                        break
                    }
                }

                if isReachable {
                    reachable.insert(program.id)
                    for subProgram in program.pipe {
                        reachable.insert(subProgram)
                    }

                    changed = true
                }
            }

            if removeElements {
                for i in (0..<programs.count).reversed() {
                    if reachable.contains(programs[i].id) {
                        programs.remove(at: i)
                    }
                }
            }
        } while changed

        return reachable.count
    }

    public func getGroupCount() -> Int {
        var groups = 0

        while getFirstGroupElements(removeElements: true) > 0 {
            groups += 1
        }

        return groups
    }
}
