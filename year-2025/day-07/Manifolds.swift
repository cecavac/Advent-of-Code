//
//  Manifolds.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.25.
//

class Manifolds {
    let startI = 0
    let startJ: Int
    var beamSplits = 0
    var area: Array<Array<Character>>

    init(_ data: String) {
        area = data.split(separator: "\n")
            .map { Array(String($0)) }

        startJ = area[startI].firstIndex(of: "S")!
        spread(i: startI + 1, j: startJ)
    }

    func spread(i: Int, j: Int) {
        if i < 0 || i >= area.count || j < 0 || j >= area[0].count {
            return
        }

        if area[i][j] == "." {
            area[i][j] = "|"
            spread(i: i + 1, j: j)
        } else if area[i][j] == "^" {
            beamSplits += 1
            spread(i: i, j: j - 1)
            spread(i: i, j: j + 1)
        }
    }

    func quantumTimelines() -> Int {
        var visits = Array(repeating: Array(repeating: 0, count: area[0].count), count: area.count)
        visits[startI][startJ] = 1

        for i in 0..<(visits.count - 1) {
            for j in visits[0].indices {
                if area[i + 1][j] == "|" {
                    visits[i + 1][j] += visits[i][j]
                    continue
                }

                if area[i + 1][j] == "^" {
                    if 0 <= j - 1 {
                        visits[i + 1][j - 1] += visits[i][j]
                    }

                    if j + 1 < visits[0].count {
                        visits[i + 1][j + 1] += visits[i][j]
                    }
                }
            }
        }

        return visits.last!.reduce(0, +)
    }
}
