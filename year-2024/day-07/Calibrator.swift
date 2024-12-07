//
//  Calibrator.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.24.
//

class Calibrator {
    var expressions: [Expression]

    init(_ data: String) {
        expressions = data.split(separator: "\n")
            .map { Expression(String($0)) }
    }

    func calibrate(extended: Bool) -> Int {
        return expressions.filter { $0.isValid(extended: extended) }
            .map { $0.result }
            .reduce(0, +)
    }
}
