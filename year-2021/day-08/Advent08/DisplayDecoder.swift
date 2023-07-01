//
//  DisplayDecoder.swift
//  Advent08
//
//  Created by Dragan Cecavac on 08.12.21.
//

import Foundation

class DisplayDecoder {
    private func decode(code: Set<Character>, mapping: [Set<Character>]) -> Int? {
        return mapping.firstIndex(of: code)
    }

    private func map(_ input: String) -> [Set<Character>] {
        var digitMappings: [Set<Character>] = Array(repeating: Set<Character>(), count: 10)
        let signals = input.split(separator: " ")

        // Select 1, 7, 4 and 8
        for value in signals {
            let currentSet = Set(Array(String(value)))
            switch currentSet.count {
            case 2:
                digitMappings[1] = currentSet
            case 3:
                digitMappings[7] = currentSet
            case 4:
                digitMappings[4] = currentSet
            case 7:
                digitMappings[8] = currentSet
            default:
                break
            }
        }

        // Select 0, 6 and 9
        for value in signals {
            let currentSet = Set(Array(String(value)))
            if currentSet.count == 6 {
                if digitMappings[4].isSubset(of: currentSet) {
                    digitMappings[9] = currentSet
                } else if digitMappings[7].isSubset(of: currentSet) {
                    digitMappings[0] = currentSet
                } else {
                    digitMappings[6] = currentSet
                }
            }
        }

        // Select 2, 3 and 5
        for value in signals {
            let currentSet = Set(Array(String(value)))
            if currentSet.count == 5 {
                if digitMappings[7].isSubset(of: currentSet) {
                    digitMappings[3] = currentSet
                } else if currentSet.isSubset(of: digitMappings[6]) {
                    digitMappings[5] = currentSet
                } else {
                    digitMappings[2] = currentSet
                }
            }
        }

        return digitMappings
    }

    func process(_ input: String) -> Int {
        var result = 0
        let components = input.split(separator: "|")
        let digitMappings = map(String(components[0]))

        let output = components[1].split(separator: " ")
        for value in output {
            result *= 10
            result += decode(code: Set(Array(String(value))), mapping: digitMappings)!
        }

        return result
    }
}
