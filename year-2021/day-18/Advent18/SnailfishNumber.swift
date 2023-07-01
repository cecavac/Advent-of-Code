//
//  SnailfishNumber.swift
//  Advent18
//
//  Created by Dragan Cecavac on 18.12.21.
//

import Foundation

class SnailfishNumber {
    var parent: SnailfishNumber? = nil
    var nodeLeft: SnailfishNumber? = nil
    var nodeRight: SnailfishNumber? = nil
    var numberLeft: Int? = nil
    var numberRight: Int? = nil
    var id: Int

    private static var id = 0

    var hasLeftElement: Bool {
        return nodeLeft != nil || numberLeft != nil
    }

    var hasRighElement: Bool {
        return nodeRight != nil || numberRight != nil
    }

    var magnitude: Int {
        var result = 0

        if let value = numberLeft {
            result += 3 * value
        } else {
            result += 3 * nodeLeft!.magnitude
        }

        if let value = numberRight {
            result += 2 * value
        } else {
            result += 2 * nodeRight!.magnitude
        }

        return result
    }

    init() {
        id = SnailfishNumber.id
        SnailfishNumber.id += 1
    }

    init(_ input: String) {
        id = SnailfishNumber.id
        SnailfishNumber.id += 1

        var elements = Array(input)
        elements.removeFirst()
        elements.removeLast()
        var currentNode: SnailfishNumber = self
        for element in elements {
            if element == "," {
                continue
            } else if element == "[" {
                let newNode = SnailfishNumber()
                if !currentNode.hasLeftElement {
                    currentNode.nodeLeft = newNode
                } else if !currentNode.hasRighElement {
                    currentNode.nodeRight = newNode
                } else {
                    print("Error, expected 1 of the child elements to be free")
                }
                newNode.parent = currentNode
                currentNode = newNode
            } else if element == "]" {
                if !currentNode.hasLeftElement || !currentNode.hasRighElement {
                    print("Error, leaving a node which has less than 2 child elements")
                }
                currentNode = currentNode.parent!
            } else if let value = Int("\(element)") {
                if !currentNode.hasLeftElement {
                    currentNode.numberLeft = value
                } else if !currentNode.hasRighElement {
                    currentNode.numberRight = value
                } else {
                    print("Error, expected 1 of the child elements to be free")
                }
            }
        }
    }

    func add(_ number: SnailfishNumber) -> SnailfishNumber {
        let newRoot = SnailfishNumber()

        newRoot.nodeLeft = self
        newRoot.nodeRight = number
        parent = newRoot
        number.parent = newRoot

        return newRoot
    }

    func findExplodable(depth: Int) -> SnailfishNumber? {
        let currentDepth = depth + 1

        if currentDepth > 4 && nodeLeft == nil && nodeRight == nil {
            return self
        }

        if nodeLeft != nil {
            let result = nodeLeft!.findExplodable(depth: currentDepth)
            if result != nil {
                return result
            }
        }

        if nodeRight != nil {
            let result = nodeRight!.findExplodable(depth: currentDepth)
            if result != nil {
                return result
            }
        }

        return nil
    }

    func findSplittable() -> SnailfishNumber? {
        if numberLeft != nil && numberLeft! > 9 {
            return self
        }

        if nodeLeft != nil {
            let result = nodeLeft!.findSplittable()
            if result != nil {
                return result
            }
        }

        if nodeRight != nil {
            let result = nodeRight!.findSplittable()
            if result != nil {
                return result
            }
        }

        if numberRight != nil && numberRight! > 9 {
            return self
        }

        return nil
    }

    func reducible() -> Bool {
        return findExplodable(depth: 0) != nil || findSplittable() != nil
    }

    func reduce() {
        if let exploadable = findExplodable(depth: 0) {
            exploadable.explode()
        } else if let splittable = findSplittable() {
            splittable.split()
        } else {
            print("Error, could not reduce the number")
        }
    }

    func fullyReduce() {
        while reducible() {
            reduce()
        }
    }

    static var nodeArray = [SnailfishNumber]()
    func InitializeNodeArray() {
        if nodeLeft != nil {
            nodeLeft!.InitializeNodeArray()
        }

        SnailfishNumber.nodeArray.append(self)

        if nodeRight != nil {
            nodeRight!.InitializeNodeArray()
        }
    }

    func explode() {
        SnailfishNumber.nodeArray.removeAll()
        var root = parent
        while root!.parent != nil {
            root = root!.parent
        }
        root!.InitializeNodeArray()

        var currentArrayIndex = -1
        for i in SnailfishNumber.nodeArray.indices {
            if SnailfishNumber.nodeArray[i].id == id {
                currentArrayIndex = i
                break
            }
        }
        if currentArrayIndex == -1 {
            print("Error, could not find currentArrayIndex")
        }

        if currentArrayIndex > 0 {
            for i in (0..<currentArrayIndex).reversed() {
                if SnailfishNumber.nodeArray[i].numberRight != nil {
                    SnailfishNumber.nodeArray[i].numberRight! += numberLeft!
                    break
                }
                if SnailfishNumber.nodeArray[i].numberLeft != nil {
                    SnailfishNumber.nodeArray[i].numberLeft! += numberLeft!
                    break
                }
            }
        }

        if currentArrayIndex + 1 < SnailfishNumber.nodeArray.count {
            for i in (currentArrayIndex + 1)..<SnailfishNumber.nodeArray.count {
                if SnailfishNumber.nodeArray[i].numberLeft != nil {
                    SnailfishNumber.nodeArray[i].numberLeft! += numberRight!
                    break
                }
                if SnailfishNumber.nodeArray[i].numberRight != nil {
                    SnailfishNumber.nodeArray[i].numberRight! += numberRight!
                    break
                }
            }
        }

        if parent!.nodeLeft != nil && parent!.nodeLeft!.id == id {
            parent!.nodeLeft = nil
            parent!.numberLeft = 0
        } else if parent!.nodeRight != nil && parent!.nodeRight!.id == id {
            parent!.nodeRight = nil
            parent!.numberRight = 0
        } else {
            print("Error, parent does not contain the exploding element")
        }
    }

    func split() {
        let newNode = SnailfishNumber()

        if numberLeft != nil && numberLeft! > 9 {
            let left = numberLeft! / 2
            let right = numberLeft! / 2 + numberLeft! % 2
            newNode.numberLeft = left
            newNode.numberRight = right
            numberLeft = nil
            nodeLeft = newNode
        } else if numberRight != nil && numberRight! > 9 {
            let left = numberRight! / 2
            let right = numberRight! / 2 + numberRight! % 2
            newNode.numberLeft = left
            newNode.numberRight = right
            numberRight = nil
            nodeRight = newNode
        } else {
            print("Error, the number is not splittable")
        }

        newNode.parent = self
    }

    func show() -> String {
        var result = "["

        if numberLeft != nil {
            result += "\(numberLeft!)"
        }

        if nodeLeft != nil {
            result += nodeLeft!.show()
        }

        result += ","

        if numberRight != nil {
            result += "\(numberRight!)"
        }

        if nodeRight != nil {
            result += nodeRight!.show()
        }

        result += "]"
        return result
    }
}
