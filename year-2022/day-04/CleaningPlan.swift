//
//  CleaningPlan.swift
//  Advent04
//
//  Created by Dragan Cecavac on 04.12.22.
//

import Foundation

class CleaningPlan {
    let pairs: [(Section, Section)]

    init(_ input: String) {
        pairs = input.split(separator: "\n").map {
            let data = $0.split(separator: ",")
            return (Section(String(data[0])), Section(String(data[1])))
        }
    }

    func overlapCount() -> Int {
        return pairs.filter { $0.0.overlaps(with: $0.1) }.count
    }

    func fullOverlapCount() -> Int {
        return pairs.filter { $0.0.fullyOverlaps(with: $0.1) }.count
    }
}
