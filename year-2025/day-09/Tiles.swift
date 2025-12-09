//
//  Tiles.swift
//  day-09
//
//  Created by Dragan Cecavac on 09.12.25.
//

class Tiles {
    var points: Array<Point>
    var horizontalLines = Array<Line>()
    var verticalLines = Array<Line>()

    init(_ data: String) {
        points = data.split(separator: "\n")
            .map {
                let elements = $0.split(separator: ",")
                return Point(
                    x: Int(String(elements[0]))!,
                    y: Int(String(elements[1]))!
                )
            }

        for i in points.indices {
            let point1 = points[i]
            let point2 = points[(i + 1) % points.count]
            let line = Line(start: point1, end: point2)
            if line.isHorizontal {
                horizontalLines.append(line)
            } else {
                verticalLines.append(line)
            }
        }
    }

    func isRectangleValid(point1: Point, point2: Point) -> Bool {
        let left = min(point1.x, point2.x)
        let right = max(point1.x, point2.x)
        let top = min(point1.y, point2.y)
        let bottom = max(point1.y, point2.y)

        for line in horizontalLines {
            let lineY = line.start.y
            let lineLeft = min(line.start.x, line.end.x)
            let lineRight = max(line.start.x, line.end.x)

            if top < lineY && lineY < bottom {
                if !(lineRight <= left || right <= lineLeft) {
                    return false
                }
            }
        }

        for line in verticalLines {
            let lineX = line.start.x
            let lineTop = min(line.start.y, line.end.y)
            let lineBottom = max(line.start.y, line.end.y)

            if left < lineX && lineX < right {
                if !(lineBottom <= top || bottom <= lineTop) {
                    return false
                }
            }
        }

        return true
    }

    func findLargest(validByDefault: Bool) -> Int {
        var largest = 0
        for i in 0..<(points.count - 1) {
            for j in (i + 1)..<points.count {
                let point1 = points[i]
                let point2 = points[j]

                let height = abs(point1.x - point2.x) + 1
                let width = abs(point1.y - point2.y) + 1
                let area = height * width
                if area <= largest {
                    continue
                }

                if validByDefault || isRectangleValid(point1: point1, point2: point2) {
                    largest = max(largest, area)
                }
            }
        }

        return largest
    }
}
