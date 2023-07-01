//
//  Trees.swift
//  Advent08
//
//  Created by Dragan Cecavac on 08.12.22.
//

import Foundation

class Trees {
    var trees = [[Int]]()

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            var row = [Int]()
            for c in Array(String(line)) {
                row.append(Int(String(c))!) // map
            }
            trees.append(row)
        }
    }

    private func alignedTreeSections(i: Int, j: Int) -> [[Int]] {
        var sections = Array(repeating: [Int](), count: 4)

        for j in 0..<j {
            sections[0].append(trees[i][j])
        }
        for j in j + 1..<trees[0].count {
            sections[1].append(trees[i][j])
        }
        for i in 0..<i {
            sections[2].append(trees[i][j])
        }
        for i in i + 1..<trees.count {
            sections[3].append(trees[i][j])
        }

        return sections
    }

    private func isVisible(i: Int, j: Int) -> Bool {
        if i == 0 || i == trees.count - 1 ||
            j == 0 || j == trees[0].count - 1 {
            return true
        }

        for section in alignedTreeSections(i: i, j: j) {
            if section.max()! < trees[i][j] {
                return true
            }
        }

        return false
    }

    func visible() -> Int {
        var result = 0

        for i in 0..<trees.count {
            for j in 0..<trees[0].count {
                if isVisible(i: i, j: j) {
                    result += 1
                }
            }
        }

        return result
    }

    private func score(i: Int, j: Int) -> Int {
        var counts = Array(repeating: 0, count: 4)
        let sections = alignedTreeSections(i: i, j: j)

        for z in 0..<4 {
            var adjustedSection = sections[z]
            if z % 2 == 0 {
                adjustedSection = adjustedSection.reversed()
            }
            for tree in adjustedSection {
                counts[z] += 1
                if trees[i][j] <= tree {
                    break
                }
            }
        }

        return counts.reduce(1, *)
    }

    func scores() -> Int {
        var result = 0

        for i in 1..<trees.count - 1 {
            for j in 1..<trees[0].count - 1 {
                result = max(score(i: i, j: j), result)
            }
        }

        return result
    }
}
