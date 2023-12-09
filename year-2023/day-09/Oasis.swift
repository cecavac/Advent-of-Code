//
//  Oasis.swift
//  day-09
//
//  Created by Dragan Cecavac on 09.12.23.
//

import Foundation

class Oasis {
    var sequences = [Sequence]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            let data = line.split(separator: " ")
            var history = [Int]()
            for field in data {
                history.append(Int(String(field))!)
            }

            let sequence = Sequence(history: history)
            sequence.expand()
            sequence.predict()
            sequences.append(sequence)
        }
    }

    func nextValues() -> Int {
        return sequences.map { $0.nextValue() }.reduce(0, +)
    }

    func previousValues() -> Int {
        return sequences.map { $0.previousValue() }.reduce(0, +)
    }
}
