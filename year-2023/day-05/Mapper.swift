//
//  Mapper.swift
//  day-05
//
//  Created by Dragan Cecavac on 05.12.23.
//

import Foundation

class Mapper {
    var transforms = [Transform]()

    init( _ input: String) {
        var lines = input.split(separator: "\n")
        lines.removeFirst()

        for line in lines {
            let data = line.split(separator: " ")
            let transform = Transform(
                destination: Int(String(data[0]))!,
                source: Int(String(data[1]))!,
                length: Int(String(data[2]))!
            )
            transforms.append(transform)
        }
    }

    func sourceToDestination(_ input: Int) -> Int {
        for transform in transforms {
            if let result = transform.sourceToDestination(input) {
                return result
            }
        }

        return input
    }

    func destinationToSource(_ input: Int) -> Int {
        for transform in transforms {
            if let result = transform.destinationToSource(input) {
                return result
            }
        }

        return input
    }

    func collectEdgeDestinations() -> [Int] {
        var result = [Int]()

        for transform in transforms {
            result.append(transform.destination)
            result.append(transform.destination + transform.length - 1)
        }

        return result
    }
}
