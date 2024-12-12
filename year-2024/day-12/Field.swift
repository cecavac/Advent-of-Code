//
//  Field.swift
//  day-12
//
//  Created by Dragan Cecavac on 12.12.24.
//

class Field {
    let map: [[Character]]
    var fences: [[Character]]
    var visitedFields: [[Bool]]
    var doubleFences: Set<(Int)>
    var visitedFences: Set<(Int)>
    var result1 = 0
    var result2 = 0


    init(_ data: String) {
        map = data.split(separator: "\n")
                .map { Array(String($0)) }
        visitedFields = Array(repeating: Array(repeating: false, count: map[0].count), count: map.count)
        fences = Array(repeating: Array(repeating: ".", count: map[0].count + 2), count: map.count + 2)
        doubleFences = Set()
        visitedFences = Set()

        calculate()
    }

    let deltas = [(0, 1), (0, -1), (1, 0), (-1, 0)]

    func encode(i: Int, j: Int) -> Int {
        return i * 1000 + j
    }

    func decode(value: Int) -> (Int, Int) {
        return (value / 1000, value % 1000)
    }

    func addFence(i: Int, j: Int, delta: (Int, Int)) {
        let fenceI = 1 + delta.0 + i
        let fenceJ = 1 + delta.1 + j

        let doubleFenceI = 1 + delta.0 + (i * 2)
        let doubleFenceJ = 1 + delta.1 + (j * 2)

        fences[fenceI][fenceJ] = "x"

        if delta.1 == 0 {
            doubleFences.insert(encode(i: doubleFenceI, j: doubleFenceJ))
            doubleFences.insert(encode(i: doubleFenceI, j: doubleFenceJ + 1))
        } else {
            doubleFences.insert(encode(i: doubleFenceI, j: doubleFenceJ))
            doubleFences.insert(encode(i: doubleFenceI + 1, j: doubleFenceJ))
        }
    }

    func exploreArea(i: Int, j: Int, plant: Character) -> (Int, Int) {
        var size = 1
        var fenceCount = 0
        visitedFields[i][j] = true

        for delta in deltas {
            let offsetI = delta.0 + i
            let offsetJ = delta.1 + j

            if offsetI >= 0 && offsetI < map.count
                && offsetJ >= 0 && offsetJ < map[0].count {
                if map[offsetI][offsetJ] == plant && !visitedFields[offsetI][offsetJ] {
                    let (newSize, newFenceCount) = exploreArea(i: offsetI, j: offsetJ, plant: plant)
                    size += newSize
                    fenceCount += newFenceCount
                }

                if map[offsetI][offsetJ] != plant {
                    fenceCount += 1
                    addFence(i: i, j: j, delta: delta)
                }
            } else {
                fenceCount += 1
                addFence(i: i, j: j, delta: delta)
            }
        }

        return (size, fenceCount)
    }

    func visitFences(i: Int, j: Int, horizontal: Bool) {
        if horizontal {
            for z in j..<(fences[0].count * 2) {
                if !doubleFences.contains(encode(i: i, j: z)) {
                    break
                }

                visitedFences.insert(encode(i: i, j: z))
            }
            for z in (0..<j).reversed() {
                if !doubleFences.contains(encode(i: i, j: z)) {
                    break
                }

                visitedFences.insert(encode(i: i, j: z))
            }
        } else {
            for z in i..<(fences.count * 2) {
                if !doubleFences.contains(encode(i: z, j: j)) {
                    break
                }

                visitedFences.insert(encode(i: z, j: j))
            }
            for z in (0..<i).reversed() {
                if !doubleFences.contains(encode(i: z, j: j)) {
                    break
                }

                visitedFences.insert(encode(i: z, j: j))
            }
        }
    }

    func surroundingFences(fence: Int) -> [Bool] {
        let (i, j) = decode(value: fence)

        let leftExists = doubleFences.contains(encode(i: i, j: j - 1))
        let rightExists = doubleFences.contains(encode(i: i, j: j + 1))
        let upExists = doubleFences.contains(encode(i: i - 1, j: j))
        let downExists = doubleFences.contains(encode(i: i + 1, j: j))

        return [leftExists, rightExists, upExists, downExists]
    }

    func trimFenceCorners() {
        for fence in doubleFences {
            let surrounding = surroundingFences(fence: fence)
            let leftExists = surrounding[0]
            let rightExists = surrounding[1]
            let upExists = surrounding[2]
            let downExists = surrounding[3]

            if (leftExists && upExists)
                || (leftExists && downExists)
                || (rightExists && upExists)
                || (rightExists && downExists) {
                doubleFences.remove(fence)
            }
        }
    }

    func countSides() -> Int {
        var sides = 0

        for fence in doubleFences {
            if !visitedFences.contains(fence) {
                visitedFences.insert(fence)
                sides += 1

                let surrounding = surroundingFences(fence: fence)
                let leftExists = surrounding[0]
                let rightExists = surrounding[1]
                let upExists = surrounding[2]
                let downExists = surrounding[3]

                if leftExists || rightExists || upExists || downExists {
                    let (i, j) = decode(value: fence)
                    visitFences(i: i, j: j, horizontal: leftExists || rightExists)
                }
            }
        }

        fences = Array(repeating: Array(repeating: ".", count: map[0].count + 2), count: map.count + 2)
        doubleFences = Set()
        visitedFences = Set()

        return sides
    }

    func calculate() {
        for i in map.indices {
            for j in map[0].indices {
                if !visitedFields[i][j] {
                    let (size, fences) = exploreArea(i: i, j: j, plant: map[i][j])
                    trimFenceCorners()
                    let sides = countSides()

                    result1 += size * fences
                    result2 += size * sides
                }
            }
        }
    }
}
