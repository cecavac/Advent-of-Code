//
//  Section.swift
//  Advent04
//
//  Created by Dragan Cecavac on 04.12.22.
//

import Foundation

struct Section {
    let start: UInt
    let end: UInt

    init(_ input: String) {
        let elements = input.split(separator: "-")
        start = UInt(String(elements[0]))!
        end = UInt(String(elements[1]))!
    }

    func overlaps(with other: Section) -> Bool {
        return (start <= other.start && other.start <= end) ||
        (other.start <= start && start <= other.end)
    }

    func fullyOverlaps(with other: Section) -> Bool {
        return (start <= other.start && other.end <= end) ||
        (other.start <= start && end <= other.end)
    }
}
