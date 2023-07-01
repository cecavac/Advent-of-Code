//
//  Crane.swift
//  Advent05
//
//  Created by Dragan Cecavac on 05.12.22.
//

import Foundation

class Crane {
    var stacks: [[Character]]
    let movementData: [String]

    init(_ input: String) {
        let lines = input.split(separator: "\n\n")
        let stackData = lines[0].split(separator: "\n")
        let craneCount = Int(String(stackData.last!.split(separator: " ").last!))!
        stacks = Array(repeating: [Character](), count: craneCount)

        for i in 0..<stackData.count - 1 {
            let observedCrates = Array(String(stackData[i]))
            for j in 0..<craneCount {
                let crateIndex = j * 4 + 1
                if observedCrates.count + 1 > crateIndex {
                    if observedCrates[crateIndex] != " " {
                        stacks[j].insert(observedCrates[crateIndex], at: 0)
                    }
                }
            }
        }

        movementData = lines[1].split(separator: "\n").map { String($0) }
    }

    func move(multiple: Bool) -> String {
        var stacksCopy = stacks

        for data in movementData {
            let info = data.split(separator: " ")
            let amount = Int(String(info[1]))!
            let from = Int(String(info[3]))! - 1
            let to = Int(String(info[5]))! - 1

            var movedCrates = [Character]()
            for _ in 0..<amount {
                let crate = stacksCopy[from].removeLast()
                movedCrates.append(crate)
            }
            if multiple {
                movedCrates = movedCrates.reversed()
            }
            stacksCopy[to] += movedCrates
        }

        return stacksCopy.map { "\($0.last!)" }.reduce("", +)
    }
}
