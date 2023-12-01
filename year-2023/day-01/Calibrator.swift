//
//  Calibrator.swift
//  day-01
//
//  Created by Dragan Cecavac on 01.12.23.
//

import Foundation

class Calibrator {
    private let data: [String]
    private static let characterMap = [
        "1" : "one",
        "2" : "two",
        "3" : "three",
        "4" : "four",
        "5" : "five",
        "6" : "six",
        "7" : "seven",
        "8" : "eight",
        "9" : "nine"
    ]

    init(_ input: String) {
        data = input.split(separator: "\n").map{ String($0) }
    }

    private func sumOfEdgeIndicies(_ input: [Character]) -> Int {
        let digitIndices = input.indices.filter {
            Calibrator.characterMap.keys.contains(String(input[$0]))
        }

        let mostLeft = Int(String(input[digitIndices.first!]))!
        let mostRight = Int(String(input[digitIndices.last!]))!
        return mostLeft * 10 + mostRight
    }

    private func calibrate(_ input: String, withReplacement: Bool) -> Int {
        var adaptedInput = input

        if withReplacement {
            for candidate in Calibrator.characterMap {
                let expandedFormat = "\(candidate.value)\(candidate.key)\(candidate.value)"
                adaptedInput = adaptedInput.replacingOccurrences(of: candidate.value, with: expandedFormat)
            }
        }

        return sumOfEdgeIndicies(Array(adaptedInput))
    }

    func calibrate(withReplacement: Bool) -> Int {
        return data.map {
            calibrate($0, withReplacement: withReplacement)
        }.reduce(0, +)
    }
}
