//
//  Scanner.swift
//  Advent15
//
//  Created by Dragan Cecavac on 15.12.22.
//

import Foundation

class Scanner {
    var pairs = [Pair]()
    var pointsInUse = Set<String>()

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            var adjustedString = line.replacingOccurrences(of: "=", with: " ")
            adjustedString = adjustedString.replacingOccurrences(of: ",", with: "")
            adjustedString = adjustedString.replacingOccurrences(of: ":", with: "")
            let elements = adjustedString.split(separator: " ")
            let sensorJ = Int(String(elements[3]))!
            let sensorI = Int(String(elements[5]))!
            let sensor = Node(i: sensorI, j: sensorJ)
            let beaconJ = Int(String(elements[11]))!
            let beaconI = Int(String(elements[13]))!
            let beacon = Node(i: beaconI, j: beaconJ)
            let distance = sensor.distance(to: beacon)
            pairs.append(Pair(sensor: sensor, beacon: beacon, distance: distance))

            for pair in pairs {
                pointsInUse.insert("\(pair.sensor.i)#\(pair.sensor.j)")
                pointsInUse.insert("\(pair.beacon.i)#\(pair.beacon.j)")
            }

        }
    }

    func contains(point: Int, ranges: [Range]) -> Bool {
        for range in ranges {
            if range.contains(point: point) {
                return true
            }
        }
        return false
    }

    func minimize(ranges: [Range]) -> [Range] {
        var impossibleRanges = ranges
        var changed: Bool

        repeat {
            changed = false
            var combined = [Int]()
            var newRanges = [Range]()

            for i in impossibleRanges.indices {
                for j in impossibleRanges.indices {

                    if i != j &&
                        !combined.contains(i) &&
                        !combined.contains(j) &&
                        (impossibleRanges[i].collides(with: impossibleRanges[j]) ||
                         impossibleRanges[i].adjacent(with: impossibleRanges[j])){
                        newRanges.append(impossibleRanges[i].combine(with: impossibleRanges[j]))
                        combined.append(i)
                        combined.append(j)
                        changed = true
                    }
                }
            }

            for i in impossibleRanges.indices {
                if !combined.contains(i) {
                    newRanges.append(impossibleRanges[i])
                }
            }

            impossibleRanges = newRanges
        } while changed

        return impossibleRanges
    }

    func impossibles(row: Int) -> [Range] {
        var impossibleRanges = [Range]()
        for pair in pairs {
            let verticalDistance = abs(row - pair.sensor.i)
            let horizontalScope = pair.distance - verticalDistance
            if horizontalScope > 0 {
                let pairRange = Range(start: pair.sensor.j - horizontalScope, end: pair.sensor.j + horizontalScope)
                impossibleRanges.append(pairRange)
            }
        }

        return minimize(ranges: impossibleRanges)
    }

    func adjustedImpossibles(row: Int) -> Int {
        var result = 0
        let impossibleRanges = impossibles(row: row)
        for range in impossibleRanges {
            result += range.length()
        }

        for point in pointsInUse {
            let data = point.split(separator: "#")
            let pointI = Int(String(data[0]))!
            let pointJ = Int(String(data[0]))!

            if pointI == row && contains(point: pointJ, ranges: impossibleRanges) {
                result -= 1
            }
        }

        return result
    }

    // Aim to cover 2 first and second half, otherwise proceed to full row scan
    func canBeSkipped(low: Int, high: Int, row: Int) -> Bool {
        let width = high - low
        var firstHalfCovered = false
        var secondHalfCovered = false

        for pair in pairs {
            let rowDistance = abs(row - pair.sensor.i)


            let distanceToStart = abs(low - pair.sensor.j) + rowDistance
            let distanceToMid = abs(width / 2 - pair.sensor.j) + rowDistance
            let distanceToEnd = abs(high - pair.sensor.j) + rowDistance

            if distanceToStart <= pair.distance && distanceToMid <= pair.distance {
                firstHalfCovered = true
            }
            if distanceToMid <= pair.distance && distanceToEnd <= pair.distance {
                secondHalfCovered = true
            }

            if firstHalfCovered && secondHalfCovered {
                return true
            }
        }

        return false
    }

    func find(low: Int, high: Int) -> Int {
        let scope = high - low
        let percent = scope / 100

        // Reversing is a cheap "optimization", at least for my input
        for i in (low...high).reversed() {
            if i % percent == 0 {
                let percentage = 100 * i / scope
                print("\(percentage)% remains to be scanned.")
            }

            if canBeSkipped(low: low, high: high, row: i) {
                continue
            }

            var impossibleRanges = impossibles(row: i)
            impossibleRanges.sort(by: { $0.start < $1.start })

            if 0 <= impossibleRanges[0].start - 1 &&
                impossibleRanges[0].start - 1 <= high {
                return i +  (impossibleRanges[0].start - 1) * 4000000
            }

            for j in 0..<impossibleRanges.count {
                if 0 <= impossibleRanges[j].end &&
                    impossibleRanges[j].end <= high {
                    return i +  (impossibleRanges[j].end + 1) * 4000000
                }
            }
        }

        return 0
    }
}
