//
//  Blueprint.swift
//  Advent19
//
//  Created by Dragan Cecavac on 19.12.22.
//

import Foundation

class Blueprint {
    var factories = [RobotFactory]()

    init(_ input: String, limit: Int?) {
        for line in input.split(separator: "\n") {
            factories.append(RobotFactory(String(line)))
        }

        if let limitCount = limit {
            var limitedFactories = [RobotFactory]()
            for i in 0..<limitCount{
                limitedFactories.append(factories[i])
            }
            factories = limitedFactories
        }
    }

    func build(minutes: Int, multiply: Bool) -> Int {
        var result = 0
        if multiply {
            result += 1
        }
        for factory in factories {
            RobotFactory.bestEver = 0
            RobotFactory.cache.removeAll()
            if multiply {
                result *= factory.build(minute: 1, depth: minutes + 1)
            } else {
                result += factory.build(minute: 1, depth: minutes + 1) * factory.id
            }
            print("=")
        }
        return result
    }
}
