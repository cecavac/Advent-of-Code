//
//  Line.swift
//  day-09
//
//  Created by Dragan Cecavac on 09.12.25.
//

struct Line {
    let start: Point
    let end: Point
    let isHorizontal: Bool

    init(start: Point, end: Point) {
        let xMatch = start.x == end.x
        let yMatch = start.y == end.y

        if xMatch && yMatch {
            fatalError("Can't form a line from 2 same dots")
        }

        if !xMatch && !yMatch {
            fatalError("Lines must be orthogonal")
        }

        self.isHorizontal = yMatch
        self.start = start
        self.end = end
    }
}
