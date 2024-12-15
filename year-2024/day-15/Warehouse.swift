//
//  Warehouse.swift
//  day-15
//
//  Created by Dragan Cecavac on 15.12.24.
//

class Warehouse {
    var map: [[Character]]
    let moves: [[Character]]

    var robotI = -1
    var robotJ = -1

    let offsets: [Character:(Int, Int)] = [
        "<": (0, -1),
        ">": (0, 1),
        "^": (-1, 0),
        "v": (1, 0),
    ]

    init(_ data: String, stretch: Bool) {
        let sections = data.split(separator: "\n\n")
        let tmpMap = sections[0].split(separator: "\n")
            .map { Array(String($0)) }
        moves = sections[1].split(separator: "\n")
            .map { Array(String($0)) }

        if stretch {
            map = []
            for i in tmpMap.indices {
                map.append([])
                for j in tmpMap[0].indices {
                    let element = tmpMap[i][j]
                    if element == "." {
                        map[i].append(".")
                        map[i].append(".")
                    } else if element == "#" {
                        map[i].append("#")
                        map[i].append("#")
                    } else if element == "O" {
                        map[i].append("[")
                        map[i].append("]")
                    } else if element == "@" {
                        map[i].append("@")
                        map[i].append(".")

                    } else {
                        fatalError("Unexpected character")
                    }
                }
            }
        } else {
            map = tmpMap
        }

        findRobot()
    }

    func findRobot() {
        for i in map.indices {
            for j in map[0].indices {
                if map[i][j] == "@" {
                    robotI = i
                    robotJ = j
                    return
                }
            }
        }
        fatalError("Robot not found")
    }

    func pushIfPossible(fromI: Int, fromJ: Int, move: Character) -> Bool {
        let (offsetI, offsetJ) = offsets[move]!
        let i = fromI + offsetI
        let j = fromJ + offsetJ

        let currentElement = map[fromI][fromJ]
        let nextElement = map[i][j]
        let vertical = move == "v" || move == "^"
        let robotPosition = currentElement == "@"
        let smallBox = currentElement == "O"

        if nextElement == "#" {
            return false
        }

        if nextElement == "." {
            let tmp = map[i][j]
            map[i][j] = map[fromI][fromJ]
            map[fromI][fromJ] = tmp

            if robotPosition || !vertical || smallBox {
                return true
            }
        } else {
            if pushIfPossible(fromI: i, fromJ: j, move: move) {
                let tmp = map[i][j]
                map[i][j] = map[fromI][fromJ]
                map[fromI][fromJ] = tmp
            } else {
                return false
            }
        }

        var left = false
        var right = false
        let leftJ = j - 1
        let rightJ = j + 1

        if vertical {
            if robotPosition {
                left = nextElement == "]"
                right = nextElement == "["
            } else if currentElement == "[" {
                left = nextElement == "]"
            } else if currentElement == "]" {
                right = nextElement == "["
            } else if currentElement != "O" {
                fatalError("Invalid element \(currentElement)")
            }
        }

        if left && !pushIfPossible(fromI: i, fromJ: leftJ, move: move) {
            return false
        }

        if right && !pushIfPossible(fromI: i, fromJ: rightJ, move: move) {
            return false
        }

        return true
    }

    func walk() {
        for moveLine in moves {
            for move in moveLine {
                let mapSnapshot = map
                if pushIfPossible(fromI: robotI, fromJ: robotJ, move: move) {
                    let (offsetI, offsetJ) = offsets[move]!
                    robotI += offsetI
                    robotJ += offsetJ
                } else {
                    map = mapSnapshot
                }
            }
        }
    }

    func score() -> Int {
        var result = 0

        for i in map.indices {
            for j in map[0].indices {
                if map[i][j] == "[" || map[i][j] == "O" {
                    result += (100 * i) + j
                }
            }
        }

        return result
    }
}
