//
//  Library.swift
//  day-15
//
//  Created by Dragan Cecavac on 15.12.23.
//

import Foundation

class Library {
    var rawInput: String

    var boxes = Array(repeating: [Lens](), count: 256)

    init(_ input: String) {
        self.rawInput = input
    }

    func hash(_ input: String) -> Int {
        var result = 0

        for char in input {
            result += Int(char.asciiValue!)
            result *= 17
            result %= 256
        }

        return result
    }

    func sum() -> Int {
        return rawInput.split(separator: ",")
            .map { hash(String($0)) }
            .reduce(0, +)
    }

    func sum2() -> Int {
        for component in rawInput.split(separator: ",") {
            let parsableComponent = String(component)
                .replacingOccurrences(of: "=", with: " ")
                .replacingOccurrences(of: "-", with: " ")
            let comp = parsableComponent.split(separator: " ")
            let label = String(comp[0])
            let boxId = hash(label)

            var foundIndex: Int? = nil
            for i in boxes[boxId].indices {
                if boxes[boxId][i].label == label {
                    foundIndex = i
                    break
                }
            }

            let isRemoval = component.last == "-"
            if isRemoval {
                if let i = foundIndex {
                    boxes[boxId].remove(at: i)
                }
            } else {
                let focal = Int(String(comp[1]))!
                if let i = foundIndex {
                    boxes[boxId][i].focal = focal
                } else {
                    boxes[boxId].append(Lens(label: label, focal: focal))
                }
            }
        }

        var result = 0
        for i in boxes.indices {
            for j in boxes[i].indices {
                result += (i + 1) * (j + 1) * boxes[i][j].focal
            }
        }

        return result
    }
}
