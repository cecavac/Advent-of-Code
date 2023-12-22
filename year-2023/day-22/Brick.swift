//
//  Brick.swift
//  day-22
//
//  Created by Dragan Cecavac on 22.12.23.
//

import Foundation

class Brick: Hashable {
    static var id = 0

    static func == (lhs: Brick, rhs: Brick) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var start: Point
    var end: Point
    var id: Int

    init(start: Point, end: Point) {
        self.start = start
        self.end = end

        id = Brick.id
        Brick.id += 1
    }

    func xyOverlap(other: Brick) -> Bool {
        let xOverlap = (start.x <= other.start.x && other.start.x <= end.x) ||
        (start.x <= other.end.x && other.end.x <= end.x) ||
        (other.start.x <= start.x && start.x <= other.end.x) ||
        (other.start.x <= end.x && end.x <= other.end.x)

        let yOverlap = (start.y <= other.start.y && other.start.y <= end.y) ||
        (start.y <= other.end.y && other.end.y <= end.y) ||
        (other.start.y <= end.y && end.y <= other.end.y) ||
        (other.start.y <= end.y && end.y <= other.end.y)

        return xOverlap && yOverlap
    }
}
