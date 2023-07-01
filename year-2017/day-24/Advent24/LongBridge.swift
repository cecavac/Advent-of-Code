//
//  LongBridge.swift
//  Advent24
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class LongBridge {
    var components = Array<Component>()
    var hashedResults: [String:(Int,Int)] = [:]

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let component = Component(String(line))
            components.append(component)
        }
    }

    private func findLongest(usedSet: Set<Component>, endPort: Int) -> (Int,Int) {
        var result: Int

        var localResult = 0
        var fullLength = usedSet.count
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
            return (max(result, localResult + subResult.0),
                    usedSet.count + subResult.1)
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
            let fullResult = findLongest(usedSet: usedSetCopy, endPort: currentComponent.endB)

            if fullLength == fullResult.1 {
                result = max(result, fullResult.0)
            } else if fullLength < fullResult.1 {
                fullLength = fullResult.1
                result = fullResult.0
            }
        }

        if result != localResult {
            let subResult = result - localResult
            hashedResults[subResultHash] = (subResult, fullLength - usedSet.count)
        }

        return (result, fullLength)
    }

    public func findLongest() -> Int {
        let result = findLongest(usedSet: Set<Component>(), endPort: 0)
        return result.0
    }
}
