//
//  Tree.swift
//  Advent7
//
//  Created by Dragan Cecavac on 07.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Tree {
    var root: Node? = nil
    var troubleMaker: Node? = nil
    var desiredWeight = 0
    var map: [String:Node] = [:]

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        var clearedLines = Array<String>()

        for line in lines {
            var clearedLine = ""

            for char in line {
                if char == "(" ||
                    char == ")" ||
                    char == "-" ||
                    char == ">" ||
                    char == "," {
                    continue
                }

                clearedLine.append(char)
            }

            clearedLines.append(clearedLine)
            let elements = clearedLine.split(separator: " ")
            let nodeName = String(elements[0])
            map[nodeName] = Node(name: nodeName, value: Int(String(elements[1]))!)
        }

        for line in clearedLines {
            let elements = line.split(separator: " ")
            let nodeName = String(elements[0])
            let currentNode = map[nodeName]!

            if root == nil {
                root = currentNode
            }

            for i in 2..<elements.count {
                let childName = String(elements[i])
                let childNode = map[childName]!
                currentNode.add(child: childNode)
            }
        }
    }

    public func findRoot() -> Node {
        var changeOccurred = true

        while changeOccurred {
            changeOccurred = false

            for (_, node) in map {
                if root == nil {
                    root  = node
                }

                for child in node.children {
                    if root!.name == child.name {
                        root = node
                        changeOccurred = true
                        break
                    }
                }
            }
        }

        return root!
    }

    private func getWeight(node: Node) -> Int {
        var childrenWeight = 0
        node.total = node.value

        for child in node.children {
            childrenWeight = getWeight(node: child)
            node.total += childrenWeight
        }

        if troubleMaker == nil {
            var errorDetected = false

            for child in node.children {
                if (childrenWeight != child.total) {
                    errorDetected = true
                }
            }

            if errorDetected {
                var troubleMakerMap: [Int:Int] = [:]

                for child2 in node.children {
                    if let val = troubleMakerMap[child2.total] {
                        troubleMakerMap[child2.total] = val + 1
                    } else {
                        troubleMakerMap[child2.total] = 0
                    }
                }

                var minimal = Int.max
                var troubleMakerWeight = 0

                for (weight,occurrence) in troubleMakerMap {
                    minimal = min(minimal,occurrence)
                    troubleMakerWeight = weight
                }

                for child in node.children {
                    if child.total == troubleMakerWeight {
                        troubleMaker = child
                    } else {
                        desiredWeight = child.total
                    }
                }
            }
        }

        return node.total
    }

    public func findProperWeight() -> Int {
        var weight = getWeight(node: root!) //just hide the warning caused by bad design
        weight = troubleMaker!.total
        return desiredWeight - weight + troubleMaker!.value
    }
}
