//
//  LavaTubes.swift
//  Advent09
//
//  Created by Dragan Cecavac on 09.12.21.
//

import Foundation

class LavaTubes {
    var map: [String:Int] = [:]
    var basinCenters: [String] = []

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for i in lines.indices {
            for j in 0..<lines[i].count {
                let hash = "\(i)#\(j)"
                let charArray: [Character] = Array(String(lines[i]))
                let value = charArray[j]
                map[hash] = Int("\(value)")!
            }
        }
    }

    func getRisk() -> Int {
        var risk = 0

        for (hash, value) in map {
            let positions = hash.split(separator: "#")
            let i = Int(String(positions[0]))!
            let j = Int(String(positions[1]))!

            let neighborHashes = ["\(i - 1)#\(j)", "\(i + 1)#\(j)", "\(i)#\(j - 1)", "\(i)#\(j + 1)"]

            var isTheSmallest = true
            for neigborHash in neighborHashes {
                if let neihborValue = map[neigborHash] {
                    isTheSmallest = isTheSmallest && value < neihborValue
                }
            }
            if isTheSmallest {
                risk += value + 1
                basinCenters.append(hash)
            }
        }

        return risk
    }

    func getBasins() -> Int {
        var basinSizes = Array<Int>()

        for centerHash in basinCenters {
            var basinElements = Set<String>()
            basinElements.insert(centerHash)

            var changed: Bool
            repeat {
                changed = false
                for hash in basinElements {
                    let positions = hash.split(separator: "#")
                    let i = Int(String(positions[0]))!
                    let j = Int(String(positions[1]))!

                    let neighborHashes = ["\(i - 1)#\(j)", "\(i + 1)#\(j)", "\(i)#\(j - 1)", "\(i)#\(j + 1)"]
                    for neigborHash in neighborHashes {
                        if let neighborValue = map[neigborHash] {
                            if neighborValue < 9 && !basinElements.contains(neigborHash) {
                                basinElements.insert(neigborHash)
                                changed = true
                            }
                        }
                    }
                }

            } while changed
            basinSizes.append(basinElements.count)
        }

        basinSizes = basinSizes.sorted { $0 > $1 }
        return basinSizes[0] * basinSizes[1] * basinSizes[2]
    }
}
