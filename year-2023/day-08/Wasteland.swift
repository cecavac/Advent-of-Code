//
//  Wasteland.swift
//  day-08
//
//  Created by Dragan Cecavac on 08.12.23.
//

import Foundation

class Wasteland {
    var instructions: [Character]
    var nodes = [String:Node]()

    init(_ input: String) {
        var lines = input.split(separator: "\n")
        instructions = Array(String(lines[0]))
        lines.removeFirst()

        for line in lines {
            let nodeData = String(line)
                .replacingOccurrences(of: " = (", with: " ")
                .replacingOccurrences(of: ")", with: "")
                .replacingOccurrences(of: ",", with: "")
                .split(separator: " ")
            let name = String(nodeData[0])
            let left = String(nodeData[1])
            let right = String(nodeData[2])
            let node = Node(left: left, right: right)
            nodes[name] = node
        }
    }

    func length(start: String, targets: [String]) -> Int {
        var result = 0
        var instructionIndex = 0
        var location = start

        while !targets.contains(location) {
            result += 1
            let instruction = instructions[instructionIndex]
            instructionIndex = (instructionIndex + 1) % instructions.count

            if instruction == "L" {
                location = nodes[location]!.left
            } else {
                location = nodes[location]!.right
            }
        }

        return result
    }

    func ghostLength() -> Int {
        var result = 1
        let locations = nodes.keys.filter { $0.last == "A"}
        let targets = nodes.keys.filter { $0.last == "Z"}

        for location in locations {
            result = Math.lcm(length(start: location, targets: targets), result)
        }

        return result
    }
}
