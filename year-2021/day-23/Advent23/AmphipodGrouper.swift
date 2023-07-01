//
//  AmphipodGrouper.swift
//  Advent23
//
//  Created by Dragan Cecavac on 23.12.21.
//

import Foundation

class AmphipodGrouper {
    var hallway: [Character?]
    var rooms = Array<[Character?]>(repeating: [Character?](), count: 4)

    let consumption: [Character:Int] = ["A" : 1, "B" : 10, "C" : 100, "D" : 1000]
    let targetRooms: [Character:Int] = ["A" : 0, "B" : 1, "C" : 2, "D" : 3]
    let roomEntrances = [2, 4, 6, 8]

    var cache = [String:Int]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        hallway = Array<Character?>(repeating: nil, count: lines[1].count - 2)

        for i in 2..<(lines.count - 1) {
            let roomElements = lines[i].split(separator: "#")
            var extraOffset: Int
            if i == 2 {
                extraOffset = 0
            } else {
                extraOffset = 1
            }

            for j in rooms.indices {
                rooms[j].append(String(roomElements[j + extraOffset]).first!)
            }
        }
    }

    func isRoomEmpty(roomsVariation: [[Character?]], roomIndex: Int) -> Bool {
        for i in roomsVariation[roomIndex].indices {
            if roomsVariation[roomIndex][i] != nil {
                return false
            }
        }

        return true
    }

    func isRoomFull(roomsVariation: [[Character?]], roomIndex: Int) -> Bool {
        for i in roomsVariation[roomIndex].indices {
            if roomsVariation[roomIndex][i] == nil {
                return false
            }
        }

        return true
    }

    func canEnter(roomsVariation: [[Character?]], roomIndex: Int, amphipod: Character) -> Int? {
        if targetRooms[amphipod]! != roomIndex {
            print("Entering a wrong room")
            return nil
        }

        if isRoomFull(roomsVariation: roomsVariation, roomIndex: roomIndex) {
            return nil
        }

        for i in roomsVariation[roomIndex].indices.reversed() {
            if roomsVariation[roomIndex][i] == nil {
                return i
            } else {
                if roomsVariation[roomIndex][i]! != amphipod {
                    return nil
                }
            }
        }

        return nil
    }

    func selectedForLeaving(roomsVariation: [[Character?]], roomIndex: Int) -> Int? {
        if isRoomEmpty(roomsVariation: roomsVariation, roomIndex: roomIndex) {
            return nil
        }

        var intrudersPresent = false
        for i in roomsVariation[roomIndex].indices {
            if let amphipod = roomsVariation[roomIndex][i] {
                if targetRooms[amphipod]! != roomIndex {
                    intrudersPresent = true
                }
            }
        }

        if intrudersPresent {
            for i in roomsVariation[roomIndex].indices {
                if roomsVariation[roomIndex][i] != nil {
                    return i
                }
            }
        }

        return nil
    }

    func isThePathFromHallwayFree(hallwayVariation: [Character?], start: Int, entrance: Int) -> Bool {
        for i in min(entrance, start)...max(entrance, start) {
            if i != start && hallwayVariation[i] != nil {
                return false
            }
        }

        return true
    }

    func isThePathToHallwayFree(hallwayVariation: [Character?], goal: Int, entrance: Int) -> Bool {
        if roomEntrances.contains(goal) {
            return false
        }

        for i in min(entrance, goal)...max(entrance, goal) {
            if hallwayVariation[i] != nil {
                return false
            }
        }

        return true
    }

    func done(hallwayVariation: [Character?], roomsVariation: [[Character?]]) -> Bool {
        for i in roomsVariation.indices {
            for j in roomsVariation.first!.indices {
                if roomsVariation[i][j] == nil
                    || targetRooms[roomsVariation[i][j]!]! != i {
                    return false
                }
            }
        }

        return true
    }

    func group(hallwayVariation: [Character?], roomsVariation: [[Character?]]) -> Int {
        if done(hallwayVariation: hallwayVariation, roomsVariation: roomsVariation) {
            return 0
        }

        var bestLocalScore = Int.max

        for i in hallwayVariation.indices {
            var localHallway = hallwayVariation
            var localRooms = roomsVariation

            if let currentAmphipod = localHallway[i] {
                let targetRoom = targetRooms[currentAmphipod]!
                let entrance = roomEntrances[targetRoom]
                if let focusPoint = canEnter(roomsVariation: localRooms, roomIndex: targetRoom, amphipod: currentAmphipod) {
                    if isThePathFromHallwayFree(hallwayVariation: localHallway, start: i, entrance: entrance) {
                        let distance = abs(i - entrance) + focusPoint + 1
                        let localScore = distance * consumption[currentAmphipod]!

                        localHallway[i] = nil
                        localRooms[targetRoom][focusPoint] = currentAmphipod

                        let stateHash = description(hallwayVariation: localHallway, roomsVariation: localRooms)
                        if let cachedScore = cache[stateHash] {
                            if cachedScore < Int.max {
                                bestLocalScore = min(localScore + cachedScore, bestLocalScore)
                            }
                        } else {
                            let result = group(hallwayVariation: localHallway, roomsVariation: localRooms)
                            cache[stateHash] = result
                            if result < Int.max {
                                bestLocalScore = min(localScore + result, bestLocalScore)
                            }
                        }
                    }
                }
            }
        }

        for i in roomsVariation.indices {
            if let focusPoint = selectedForLeaving(roomsVariation: roomsVariation, roomIndex: i) {
                let distance = focusPoint + 1
                let currentAmphipod = roomsVariation[i][focusPoint]!
                let entrance = roomEntrances[i]

                for j in hallwayVariation.indices {
                    var localHallway = hallwayVariation
                    var localRooms = roomsVariation
                    var localDistance = distance

                    if isThePathToHallwayFree(hallwayVariation: localHallway, goal: j, entrance: entrance) {
                        localDistance += abs(j - entrance)
                        let localScore = localDistance * consumption[currentAmphipod]!
                        localHallway[j] = currentAmphipod
                        localRooms[i][focusPoint] = nil

                        let stateHash = description(hallwayVariation: localHallway, roomsVariation: localRooms)
                        if let cachedScore = cache[stateHash] {
                            if cachedScore < Int.max {
                                bestLocalScore = min(localScore + cachedScore, bestLocalScore)
                            }
                        } else {
                            let result = group(hallwayVariation: localHallway, roomsVariation: localRooms)
                            cache[stateHash] = result
                            if result < Int.max {
                                bestLocalScore = min(localScore + result, bestLocalScore)
                            }
                        }
                    }
                }
            }
        }

        return bestLocalScore
    }

    func group() -> Int {
        return group(hallwayVariation: hallway, roomsVariation: rooms)
    }

    func description(hallwayVariation: [Character?], roomsVariation: [[Character?]]) -> String {
        var line = ""
        for i in hallwayVariation.indices {
            if let amphipod = hallwayVariation[i] {
                line += "\(amphipod)"
            } else {
                line += "."
            }
        }
        line += "\n"

        for i in roomsVariation.first!.indices {
            line += "  "
            for j in roomsVariation.indices {
                if let amphipod = roomsVariation[j][i] {
                    line += "\(amphipod) "
                } else {
                    line += ". "
                }
            }
            line += "\n"
        }

        return line
    }
}
