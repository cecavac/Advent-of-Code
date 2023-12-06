//
//  BoatRace.swift
//  day-06
//
//  Created by Dragan Cecavac on 06.12.23.
//

import Foundation

class BoatRace {
    var times = [Int]()
    var distances = [Int]()

    let combinedTime: Int
    let combinedDistance: Int

    init(_ input: String) {
        let lines = input.split(separator: "\n")


        let timeLine = lines[0].split(separator: " ")
        for i in 1..<timeLine.count {
            times.append(Int(String(timeLine[i]))!)
        }

        let distanceLine = lines[1].split(separator: " ")
        for i in 1..<distanceLine.count {
            distances.append(Int(String(distanceLine[i]))!)
        }

        let combinedTimeLine = String(lines[0]).replacingOccurrences(of: " ", with: "").split(separator: ":")
        combinedTime = Int(String(combinedTimeLine[1]))!

        let combinedDistanceLine = String(lines[1]).replacingOccurrences(of: " ", with: "").split(separator: ":")
        combinedDistance = Int(String(combinedDistanceLine[1]))!
    }

    func waysToWin(time: Int, distance: Int) -> Int {
        let disciminant = Int(Double(time * time - (4 * distance)).squareRoot())
        let x1 = (time - disciminant) / 2
        let x2 = (time + disciminant) / 2

        // Check edge cases
        var bestX1 = Int.max
        var bestX2 = Int.min
        for offset in -1...1 {
            let observedX1 = x1 + offset
            let observedX2 = x2 + offset

            if (time - observedX1) * observedX1 > distance {
                bestX1 = min(bestX1, observedX1)
            }

            if (time - observedX2) * observedX2 > distance {
                bestX2 = max(bestX2, observedX2)
            }
        }

        return bestX2 - bestX1 + 1
    }

    func individualWins() -> Int {
        return times.indices
            .map { waysToWin(time: times[$0], distance: distances[$0]) }
            .reduce(1, *)
    }

    func combinedWins() -> Int {
        return waysToWin(time: combinedTime, distance: combinedDistance)
    }
}
