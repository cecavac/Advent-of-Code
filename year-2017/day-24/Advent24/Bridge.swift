//
//  Bridge.swift
//  Advent24
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Bridge {
    var components = Array<Component>()
    var hashedResults: [String:Int] = [:]

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let component = Component(String(line))
            components.append(component)
        }
    }

    private func findBest(usedSet: Set<Component>, endPort: Int) -> Int {
        var result: Int

        var localResult = 0
        for component in usedSet {
            localResult += component.endA
            localResult += component.endB
        }
        result = localResult

        var subResultHash = "\(endPort):"
        for component in components {
            if !usedSet.contains(component) {
                subResultHash += component.hash()
            }
        }

        if let subResult = hashedResults[subResultHash] {
            return max(result, localResult + subResult)
        }

        for component in components {
            if usedSet.contains(component) {
                continue
            }

            var currentComponent = component
            if currentComponent.endA != endPort {
                if currentComponent.endB == endPort {
                    currentComponent.rotate()
                } else {
                    continue
                }
            }

            var usedSetCopy = usedSet
            usedSetCopy.insert(currentComponent)
            let fullResult = findBest(usedSet: usedSetCopy, endPort: currentComponent.endB)
            result = max(result, fullResult)
        }

        if result != localResult {
            let subResult = result - localResult
            hashedResults[subResultHash] = subResult
        }

        return result
    }

    public func findBest() -> Int {
        return findBest(usedSet: Set<Component>(), endPort: 0)
    }
}
