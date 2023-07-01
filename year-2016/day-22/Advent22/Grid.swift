//
//  Grid.swift
//  Advent22
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Grid {
    var nodesList: [Node] = []
    var nodes: [[Node]] = []
    var freeSlot = 0

    init(_ input: String) {
        var lines = input.split(separator: "\n")
        lines.remove(at: 1)
        lines.remove(at: 0)

        var row: [Node] = []
        var count = 0
        for line in lines {
            let node = Node(String(line))

            nodesList.append(node)
            row.append(node)

            count += 1
            if count % 29 == 0 {
                nodes.append(row)
                row = []
            }
        }
    }

    func viablePairs() -> Int {
        var result = 0

        for i in 0..<nodesList.count {
            for j in 0..<nodesList.count {
                if nodesList[i].used > 0 &&
                    i != j &&
                    nodesList[i].used <= nodesList[j].available {
                    result += 1

                    freeSlot = nodesList[j].available
                }
            }
        }

        return result
    }

    func show() {
        for i in 0..<nodes.count {
            var row = ""

            for j in 0..<nodes[0].count {
                if i == 0 && j == 0 {
                    row += "O"
                } else if i == nodes.count - 1 && j == 0 {
                    row += "G"
                } else if nodes[i][j].available == freeSlot {
                    row += "-"
                } else if nodes[i][j].used <= freeSlot {
                    row += "."
                } else {
                    row += "#"
                }
            }

            print(row)
        }
    }

    func dataSteps() -> Int {
        var result = 0

        for node in nodesList {
            if node.available == freeSlot {
                // Go all the way up
                result += node.x
                // Go all the way left
                result += node.y
                // Reach goal location
                result += nodes.count - 1
                // Move the data all the way up
                result += (nodes.count - 2) * 5
            }
        }

        return result
    }
}
