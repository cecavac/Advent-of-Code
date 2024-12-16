//
//  Race.swift
//  day-16
//
//  Created by Dragan Cecavac on 16.12.24.
//

class Race {
    var startI = -1
    var startJ = -1
    var endI = -1
    var endJ = -1

    var best: Int
    var length: Int

    var map: [[Character]] = []
    var cache = [String:Int]()
    var places = Set<String>()

    init(_ data: String) {
        let lines = data.split(separator: "\n")

        for i in lines.indices {
            let characters = Array(lines[i])
            map.append(characters)

            for j in characters.indices {
                if characters[j] == "S" {
                    startI = i
                    startJ = j
                }

                if characters[j] == "E" {
                    endI = i
                    endJ = j
                }
            }
        }

        best = map.count * 1000 * 3 / 4
        length = map.count * 4
    }

    func find(change: (Int, Int), i: Int, j: Int, score: Int, visited: Set<String>) -> Int? {
        if map[i][j] == "E" {
            if best > score {
                places = Set<String>()
                best = score
            }
            if best == score {
                for place in visited {
                    places.insert(place)
                }
            }

            return score
        }

        let hash = "\(i)#\(j)#\(change.0)#\(change.1)"
        if let result = cache[hash] {
            if score > result {
                return nil
            }
        }
        cache[hash] = score

        if score % 1000 > length || score > best {
            return nil
        }

        var localBest = Int.max
        let deltas = [(-1, 0), (0, 1), (1, 0), (0, -1)]
        for delta in deltas {
            let sameAbsDirection = abs(delta.0) == abs(change.0) && abs(delta.1) == abs(change.1)
            let sameDirection = delta.0 == change.0 && delta.1 == change.1
            if sameAbsDirection && !sameDirection {
                // 180 turns aren't allowed
                continue
            }

            var localScore = score + 1
            if !sameDirection {
                localScore += 1000
            }

            let nextI = i + delta.0
            let nextJ = j + delta.1
            if map[nextI][nextJ] != "#" {
                let hashv = "\(nextI)#\(nextJ)"
                var newvisited = visited
                newvisited.insert(hashv)
                if let current = find(change: delta, i: nextI, j: nextJ, score: localScore, visited: newvisited) {
                    localBest = min(localBest, current)
                }
            }
        }

        return localBest
    }

    func find() -> Int {
        var visited = Set<String>()
        visited.insert("\(startI)#\(startJ)")
        return find(change: (0, 1), i: startI, j: startJ, score: 0, visited: visited)!
    }
}
