//
//  Range.swift
//  Advent15
//
//  Created by Dragan Cecavac on 15.12.22.
//

import Foundation

struct Range {
    let start: Int
    let end: Int

    func length() -> Int {
        return end - start + 1;
    }

    func contains(point p: Int) -> Bool {
        return start <= p && p <= end
    }

    func split(at p: Int) -> [Range] {
        if !contains(point: p) {
            return [self]
        }

        if start == end && p == start {
            return []
        }

        if start == p {
            return [Range(start: start + 1, end: end)]
        }

        if end == p {
            return [Range(start: start, end: end - 1)]
        }

        return [
            Range(start: start, end: p - 1),
            Range(start: p + 1, end: end)
        ]
    }

    func contains(location x: Int) -> Bool {
        return start <= x && x <= end
    }

    func collides(with other: Range) -> Bool {
        return (start <= other.start && other.start <= end) ||
                (start <= other.end && other.end <= end)
    }

    func adjacent(with other: Range) -> Bool {
        return min(end, other.end) + 1 == max(start, other.start)
    }

    func combine(with other: Range) -> Range {
        return Range(start: min(start, other.start), end: max(end, other.end))
    }
}
