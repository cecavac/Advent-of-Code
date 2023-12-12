//
//  Factory.swift
//  day-12
//
//  Created by Dragan Cecavac on 12.12.23.
//

import Foundation

class Factory {
    var rows = [Row]()

    init(_ input: String, unfold: Bool) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let row = Row(String(line), unfold: unfold)
            rows.append(row)
        }
    }

    func possibilities() -> Int {
        return rows.map { $0.possibilities(array: $0.springs) }.reduce(0, +)
    }
}
