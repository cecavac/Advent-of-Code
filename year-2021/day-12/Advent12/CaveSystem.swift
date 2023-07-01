//
//  CaveSystem.swift
//  Advent12
//
//  Created by Dragan Cecavac on 12.12.21.
//

import Foundation

class CaveSystem {
    var caves = [String:Cave]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let names = line.split(separator: "-")
            let lName = String(names[0])
            let rName = String(names[1])
            var lCave: Cave
            var rCave: Cave
            if let cave = caves[lName] {
                lCave = cave
            } else {
                lCave = Cave(lName)
                caves[lName] = lCave
            }
            if let cave = caves[rName] {
                rCave = cave
            } else {
                rCave = Cave(rName)
                caves[rName] = rCave
            }
            lCave.connect(to: rCave)
        }
    }

    private func explore(visits: [String:Int], current: Cave, visitTwice: Bool) -> Int {
        if current.name == "end" {
            return 1
        }

        var localVisits = visits
        if current.isSmall {
            localVisits[current.name]! += 1
        }

        var maxVisitsReached = false
        for (_, visitCount) in localVisits {
            if visitTwice && visitCount == 2 {
                maxVisitsReached = true
            }
        }

        var maxVisits: Int
        if visitTwice && !maxVisitsReached {
            maxVisits = 2
        } else {
            maxVisits = 1
        }

        var result = 0
        for connection in current.connections {
            if connection.name != "start" &&
                localVisits[connection.name]! < maxVisits {
                    result += explore(visits: localVisits, current: connection, visitTwice: visitTwice)
            }
        }
        return result
    }

    func explore(visitTwice: Bool) -> Int {
        var visits = [String:Int]()
        for (name,_) in caves {
            visits[name] = 0
        }

        return explore(visits: visits, current: caves["start"]!, visitTwice: visitTwice)
    }
}
