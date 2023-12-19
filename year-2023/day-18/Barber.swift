//
//  Barber.swift
//  day-18
//
//  Created by Dragan Cecavac on 18.12.23.
//

import Foundation

class Barber {
    var data = [Row]()
    var points = [Point]()
    var lines = [Line]()

    init(_ input: String, alternative: Bool) {
        for line in input.split(separator: "\n") {
            let str = String(line)
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
                .replacingOccurrences(of: "#", with: "")
            let components = str.split(separator: " ")
            var direction = Array(String(components[0])).first!
            var distance = Int(String(components[1]))!
            let unknown = Array(String(components[2]))


            if alternative {
                if unknown.last! == "0" {
                    direction = "R"
                } else if unknown.last! == "1" {
                    direction = "D"
                } else if unknown.last! == "2" {
                    direction = "L"
                } else if unknown.last! == "3" {
                    direction = "U"
                }
                distance = Int(String(unknown[0...4]), radix: 16)!
            }


            let row = Row(direction: direction, distance: distance)
            data.append(row)
        }
        walk()
    }

    func walk() {
        var i = 0
        var j = 0
        let start = Point(i: i, j: j)
        points.append(start)
        var previous = start

        for element in data {
            switch element.direction {
            case "U":
                i -= element.distance
            case "L":
                j -= element.distance
            case "D":
                i += element.distance
            case "R":
                j += element.distance
            default:
                fatalError("Unknown direction")
            }

            let newPoint = Point(i: i, j: j)
            points.append(newPoint)
            let line = Line(start: previous, end: newPoint, direction: element.direction)
            lines.append(line)
            previous = newPoint
        }
    }

    func trim() -> Int {
        var result = 0
        // Trim edges one by one until we're left with a rectangle
        while lines.count > 4 {
            var target = Int.max
            for i in 1..<(lines.count - 3) {
                let line1 = lines[i]
                let line2 = lines[i + 1]
                let line3 = lines[i + 2]

                let l1d = line1.direction
                let l2d = line2.direction
                let l3d = line3.direction
                let ud = (l1d == "U" && l2d == "R" && l3d == "D") || (l1d == "D" && l2d == "L" && l3d == "U")
                let lr = (l1d == "R" && l2d == "D" && l3d == "L") || (l1d == "L" && l2d == "U" && l3d == "R")
                let innerEdge = ud || lr
                if innerEdge {
                    target = min(target, line2.length)
                }
            }

            for i in 1..<(lines.count - 3) {
                let previousLine = lines[i - 1]
                let line1 = lines[i]
                let line2 = lines[i + 1]
                let line3 = lines[i + 2]
                let nextLine = lines[i + 3]

                if line2.length != target {
                    continue
                }

                let l1d = line1.direction
                let l2d = line2.direction
                let l3d = line3.direction
                let ud = (l1d == "U" && l2d == "R" && l3d == "D") || (l1d == "D" && l2d == "L" && l3d == "U")
                let lr = (l1d == "R" && l2d == "D" && l3d == "L") || (l1d == "L" && l2d == "U" && l3d == "R")
                let innerEdge = ud || lr

                if innerEdge {
                    lines.remove(at: i)
                    lines.remove(at: i)
                    lines.remove(at: i)

                    let size1 = min(line1.length, line3.length)
                    let size2 = line2.length

                    result += size1 * size2

                    if line1.length == line3.length {
                        lines.remove(at: i - 1)
                        lines.remove(at: i - 1)

                        let newLine = Line(start: previousLine.start, end: nextLine.end, direction: l2d)
                        lines.insert(newLine, at: i - 1)

                        var reduce = size2
                        if newLine.direction != previousLine.direction || newLine.direction != nextLine.direction {
                            if newLine.direction != previousLine.direction {
                                reduce -= previousLine.length - 1
                            }

                            if newLine.direction != nextLine.direction {
                                reduce -= nextLine.length - 1
                            }
                        }

                        result -= reduce
                    } else if line1.length < line3.length {
                        lines.remove(at: i - 1)
                        let newPrevStart = previousLine.start


                        let newPrevEnd: Point
                        if ud {
                            newPrevEnd = Point(i: previousLine.start.i, j: line3.start.j)
                        } else {
                            newPrevEnd = Point(i: line3.start.i, j: previousLine.start.j)
                        }

                        let newPrev = Line(start: newPrevStart, end: newPrevEnd, direction: l2d)
                        lines.insert(newPrev, at: i - 1)

                        let newLine3 = Line(start: newPrevEnd, end: line3.end, direction: l3d)
                        lines.insert(newLine3, at: i)

                        let reduce: Int
                        if newPrev.direction == previousLine.direction {
                            reduce = size2
                        } else {
                            reduce = newPrev.length
                        }
                        result -= reduce

                    } else {
                        lines.remove(at: i)
                        let newLine1Start = line1.start

                        let newLine1End: Point
                        if ud {
                            newLine1End = Point(i: nextLine.start.i, j: line1.start.j)
                        } else {
                            newLine1End = Point(i: line1.start.i, j: nextLine.start.j)
                        }

                        let newLine1 = Line(start: newLine1Start, end: newLine1End, direction: l1d)
                        lines.insert(newLine1, at: i)

                        let newNext = Line(start: newLine1End, end: nextLine.end, direction: l2d)
                        lines.insert(newNext, at: i + 1)

                        let reduce: Int
                        if newNext.direction == nextLine.direction {
                            reduce = size2
                        } else {
                            reduce = newNext.length
                        }
                        result -= reduce
                    }

                    break
                }

            }
        }

        result += lines[0].length * lines[1].length

        return result
    }
}
