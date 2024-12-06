//
//  Tracker.swift
//  day-06
//
//  Created by Dragan Cecavac on 06.12.24.
//

class Tracker {
    var map = [[Character]]()
    var visited = [String:Bool]()
    var log = [String:Bool]()
    let height: Int
    let width: Int

    var stuckInALoop = false
    var guardI = -1
    var guardJ = -1
    var direction = Direction.UP

    init(_ data: String) {
        let lines = data.split(separator: "\n")
        for line in lines {
            map.append(Array(String(line)))
        }
        height = map.count
        width = map[0].count
        for i in map.indices {
            for j in map[0].indices {
                if map[i][j] == "^" {
                    guardI = i
                    guardJ = j
                    mapGuardLocation()
                    _ = logGuardLocation()
                    break
                }
            }

            if guardI != -1 && guardJ != -1 {
                break
            }
        }
    }

    func mapGuardLocation() {
        let visitHash = "\(guardI)#\(guardJ)"
        visited[visitHash] = true
    }

    func logGuardLocation() -> Bool {
        let logHash = "\(guardI)#\(guardJ)#\(direction)"
        if log[logHash] == nil {
            log[logHash] = true
            return true
        } else {
            return false
        }
    }

    func exists(i: Int, j: Int) -> Bool {
        return i >= 0 && i < height && j >= 0 && j < width
    }

    func walk() {
        while true {
            var nextGuardI = guardI
            var nextGuardJ = guardJ
            switch direction {
            case .UP:
                nextGuardI -= 1
            case .DOWN:
                nextGuardI += 1
            case .LEFT:
                nextGuardJ -= 1
            case .RIGHT:
                nextGuardJ += 1
            }

            if exists(i: nextGuardI, j: nextGuardJ) {
                if map[nextGuardI][nextGuardJ] == "#" {
                    direction = direction.next()
                } else {
                    guardI = nextGuardI
                    guardJ = nextGuardJ
                    mapGuardLocation()

                    if !logGuardLocation() {
                        stuckInALoop = true
                        return
                    }
                }
            } else {
                return
            }
        }
    }
}
