//
//  Reactor.swift
//  Advent22
//
//  Created by Dragan Cecavac on 22.12.21.
//

import Foundation

class Reactor {
    var boundedActive: UInt64 = 0
    var boundedInactive: UInt64 = 0
    var steps = [Step]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var cleanLine = ""
            for char in line {
                if char == "=" || char == "." || char == "," {
                    cleanLine += " "
                } else {
                    cleanLine += "\(char)"
                }
            }

            let components = cleanLine.split(separator: " ")
            let step = Step(on: String(components[0]) == "on",
                            xl: Int(String(components[2]))!,
                            xh: Int(String(components[3]))!,
                            yl: Int(String(components[5]))!,
                            yh: Int(String(components[6]))!,
                            zl: Int(String(components[8]))!,
                            zh: Int(String(components[9]))!)
            steps.append(step)
        }
    }

    init(_ input: [Step]) {
        steps = input
    }

    func run(coreRun: Bool) -> (UInt64, UInt64) {
        for i in steps.indices {
            if coreRun && !steps[i].isCore() {
                continue
            }

            var overlappingSteps = [Step]()

            for j in i..<steps.count {
                if i != j {
                    if let overlapp = steps[i].overlapping(with: steps[j]) {
                        overlappingSteps.append(overlapp)
                    }
                }
            }

            if steps[i].on {
                boundedActive += steps[i].size()

                if overlappingSteps.count == 1 {
                    boundedActive -=  overlappingSteps[0].size()
                }
            } else {
                boundedInactive += steps[i].size()

                if overlappingSteps.count == 1 {
                    boundedInactive -=  overlappingSteps[0].size()
                }
            }

            if overlappingSteps.count > 1 {
                var identicalBounds = 0
                for step in overlappingSteps {
                    if overlappingSteps[0].boundsMatching(step) {
                        identicalBounds += 1
                    }
                }

                if identicalBounds == overlappingSteps.count {
                    // If all are the same, only the last one matters
                    let lastOverlapping = overlappingSteps.last!

                    if steps[i].on {
                        boundedActive -=  lastOverlapping.size()
                    } else {
                        boundedInactive -=  lastOverlapping.size()
                    }
                } else {
                    let subReactor = Reactor(overlappingSteps)
                    let subResult = subReactor.run(coreRun: false)

                    if steps[i].on {
                        boundedActive -= subResult.0 + subResult.1
                    } else {
                        boundedInactive -= subResult.0 + subResult.1
                    }
                }
            }
        }

        return (boundedActive, boundedInactive)
    }
}
