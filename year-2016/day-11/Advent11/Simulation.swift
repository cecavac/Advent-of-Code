//
//  Simulation.swift
//  Advent11
//
//  Created by Dragan Cecavac on 25.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Simulation {
    var leastSteps = 77

    var cache: [String:Int] = [:]

    private func run(step: Int, for environment: Environment) {
        print("\(step) ### \(leastSteps)")
        if step >= leastSteps {
            return
        }

        let possibilities = environment.possibilities
        for possibility in possibilities {
            if possibility.isDone() {
                leastSteps = step
                return
            }
        }

        for possibility in possibilities {
            if step >= leastSteps {
                return
            }

            var possibilityCopy = possibility
            let hash = possibilityCopy.hashVal()
            if let cachedStep = cache[hash] {
                if cachedStep > step {
                    cache[hash] = step
                    run(step: step + 1, for: possibilityCopy)
                }
            } else {
                cache[hash] = step
                run(step: step + 1, for: possibilityCopy)
            }
        }
    }

    func run(_ input: String) -> Int {
        let environment = Environment(input)
        run(step: 1, for: environment)

        return leastSteps
    }
}
