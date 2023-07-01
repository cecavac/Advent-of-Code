//
//  Defragmenter.swift
//  Advent14
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Defragmenter {
    var matrix = Array(repeating: Array(repeating: false, count: 128), count: 128)

    init(_ input: String) {
        let inputPattern = input + "-"
        for i in 0..<128 {
            let knotInput = inputPattern + "\(i)"
            var knotHash = KnotCypher(knotInput).transform()

            for j in 0..<32 {
                let firstDigit = knotHash.prefix(1)
                knotHash = String(knotHash.suffix(knotHash.count - 1))
                let element = Int(firstDigit, radix: 16)!

                matrix[i][j * 4 + 0] = element & 0x8 != 0
                matrix[i][j * 4 + 1] = element & 0x4 != 0
                matrix[i][j * 4 + 2] = element & 0x2 != 0
                matrix[i][j * 4 + 3] = element & 0x1 != 0
            }
        }
    }

    private func hash(i: Int, j: Int) -> String {
        return "\(i)#\(j)"
    }

    var usedCount: Int {
        var result = 0

        for i in 0..<128 {
            for j in 0..<128 {
                if matrix[i][j] {
                    result += 1
                }
            }
        }

        return result
    }

    var groupCounter: Int {
        var groups: [Set<String>] = []

        for i in 0..<128 {
            for j in 0..<128 {
                let currentHash = hash(i: i, j: j)
                var found = false
                var groupId = -1

                if matrix[i][j] {
                    for i in 0..<groups.count {
                        if groups[i].contains(currentHash) {
                            found = true
                            groupId = i
                            break
                        }
                    }

                    if !found {
                        var group = Set<String>()
                        group.insert(currentHash)
                        groups.append(group)
                        groupId = groups.count - 1
                    }

                    if i > 0 && matrix[i - 1][j] {
                        groups[groupId].insert(hash(i: i - 1, j: j))
                    }

                    if i < 127 && matrix[i + 1][j] {
                        groups[groupId].insert(hash(i: i + 1, j: j))
                    }

                    if j > 0 && matrix[i][j - 1] {
                        groups[groupId].insert(hash(i: i, j: j - 1))
                    }

                    if j < 127 && matrix[i][j + 1] {
                        groups[groupId].insert(hash(i: i, j: j + 1))
                    }
                }
            }
        }

        var changed: Bool

        repeat {
            changed = false
            var match = false
            var matchI = -1
            var matchJ = -1

            mainLoop: for i in 0..<groups.count {
                for j in i + 1..<groups.count {
                    for element1 in groups[i] {
                        for element2 in groups[j] {
                            if element1 == element2 {
                                match = true
                                matchI = i
                                matchJ = j

                                break mainLoop
                            }
                        }
                     }
                }
            }

            if match {
                for element in groups[matchJ] {
                    groups[matchI].insert(element)
                }

                groups.remove(at: matchJ)

                changed = true

                // rotate to speed up
                let group = groups.remove(at: 0)
                groups.append(group)
            }
        } while changed

        return groups.count
    }
}
