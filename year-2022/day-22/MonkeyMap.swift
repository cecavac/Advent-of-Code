//
//  MonkeyMap.swift
//  Advent22
//
//  Created by Dragan Cecavac on 22.12.22.
//

import Foundation

class MonkeyMap {
    var directions = [String]()
    var map = [[Character]]()

    var positionI = 0
    var positionJ = 0
    var facing = Facing.Right


    var squareWidth = 0
    var squareHeight = 0
    let squaresPerRow: Int


    init(_ input: String) {
        let sections = input.split(separator: "\n\n")

        var maxJ = 0
        for line in sections[0].split(separator: "\n") {
            maxJ = max(maxJ, line.count)
        }

        for line in sections[0].split(separator: "\n") {
            var row = Array(String(line))

            while row.count < maxJ {
                row.append(" ")
            }

            map.append(row)
        }

        for j in 0..<map[0].count {
            if map[0][j] == "." {
                positionJ = j
                break
            }
        }

        if map.count > map[0].count {
            squareHeight = map.count / 4
            squareWidth = map[0].count / 3
        } else {
            squareHeight = map.count / 3
            squareWidth = map[0].count / 4
        }
        if squareHeight != squareWidth {
            print("That's some strange square")
        }
        squaresPerRow = map[0].count / squareWidth

        var rawDirections = String(sections[1])
        rawDirections = rawDirections.replacingOccurrences(of: "R", with: " R ")
        rawDirections = rawDirections.replacingOccurrences(of: "L", with: " L ")
        directions = rawDirections.split(separator: " ").map { String($0) }
    }

    func score() -> Int {
        return (positionI + 1) * 1000 + (positionJ + 1) * 4 + facing.rawValue
    }

    func jumpToTheOtherSide() -> Bool {
        var stepI = 0
        var stepJ = 0
        var jumpI = positionI
        var jumpJ = positionJ

        switch facing {
        case .Up:
            stepI = -1
            jumpI = map.count - 1
        case .Left:
            stepJ = -1
            jumpJ = map[0].count - 1
        case .Down:
            stepI = 1
            jumpI = 0
        case .Right:
            stepJ = 1
            jumpJ = 0
        }

        for _ in 0..<max(map.count, map[positionJ].count) {
            if map[jumpI][jumpJ] == "#" {
                return false
            } else if map[jumpI][jumpJ] == "." {
                positionI = jumpI
                positionJ = jumpJ
                return true
            } else {
                jumpI += stepI
                jumpJ += stepJ
            }
        }

        // should not be reached
        return false
    }

    func walk() {
        for direction in directions {
            if let steps = Int(direction) {
                var stepI = 0
                var stepJ = 0
                switch facing {
                case .Up:
                    stepI = -1
                case .Left:
                    stepJ = -1
                case .Down:
                    stepI = 1
                case .Right:
                    stepJ = 1
                }

                for _ in 0..<steps {
                    if positionI + stepI == map.count ||
                        positionI + stepI == -1 ||
                        positionJ + stepJ == map[positionJ].count ||
                        positionJ + stepJ == -1 ||
                        map[positionI + stepI][positionJ + stepJ] == " " {
                        if !jumpToTheOtherSide() {
                            break
                        }
                    } else if map[positionI + stepI][positionJ + stepJ] == "#" {
                        break
                    } else if map[positionI + stepI][positionJ + stepJ] == "." {
                        positionI += stepI
                        positionJ += stepJ
                    } else {
                        print("Lost in the jungle")
                        return
                    }
                }
            } else {
                facing.rotate(to: direction)
            }
        }
    }

    func show() {
        for i in 0..<map.count {
            var line = ""
            for j in 0..<map[0].count {
                if positionI == i && positionJ == j {
                    switch facing {
                    case .Up:
                        line += "^"
                    case .Left:
                        line += "<"
                    case .Down:
                        line += "v"
                    case .Right:
                        line += ">"
                    }
                } else {
                    line += String(map[i][j])
                }
            }
            print(line)
        }

        print()
    }

    func squareBase(square: Int) -> (Int, Int) {
        let squareI = square / squaresPerRow
        let squareJ = square % squaresPerRow

        return (squareI * squareHeight, squareJ * squareWidth)
    }

    func squareBottomIndex(square: Int) -> Int {
        var (i, _) = squareBase(square: square)
        i += squareHeight - 1
        return i
    }

    func squareTopIndex(square: Int) -> Int {
        let (i, _) = squareBase(square: square)
        return i
    }

    func squareRightIndex(square: Int) -> Int {
        var (_, j) = squareBase(square: square)
        j += squareWidth - 1
        return j
    }

    func squareLeftIndex(square: Int) -> Int {
        let (_, j) = squareBase(square: square)
        return j
    }

    func jumpToTheOtherSide(hint: [[Hint]]) -> Bool {
        var jumpI = positionI
        var jumpJ = positionJ

        let squareI = positionI / squareHeight
        let squareJ = positionJ / squareWidth

        let currentSquare = squaresPerRow * squareI + squareJ
        let squareHint = hint[currentSquare]

        let hintIndex: Int
        switch facing {
        case .Up:
            hintIndex = 1
        case .Left:
            hintIndex = 0
        case .Down:
            hintIndex = 3
        case .Right:
            hintIndex = 2
        }
        let actualHint = squareHint[hintIndex]
        let nextSquare = actualHint.next
        let position = actualHint.position
        let flip = actualHint.flip

        let baseI = squareTopIndex(square: currentSquare)
        let offsetI = jumpI - baseI
        let baseJ = squareLeftIndex(square: currentSquare)
        let offsetJ = jumpJ - baseJ

        jumpI = offsetI
        jumpJ = offsetJ

        switch facing {
        case .Up:
            if position == "L" || position == "R" {
                jumpI = offsetJ
            }
        case .Left:
            if position == "T" || position == "B" {
                jumpJ = offsetI
            }
        case .Down:
            if position == "L" || position == "R" {
                jumpI = offsetJ
            }
        case .Right:
            if position == "T" || position == "B" {
                jumpJ = offsetI
            }
        }

        if flip {
            if position == "T" || position == "B" {
                jumpJ = squareWidth - jumpJ - 1
            } else {
                jumpI = squareWidth - jumpI - 1
            }
        }

        if position == "T" {
            jumpI = squareTopIndex(square: nextSquare)
            jumpJ += squareLeftIndex(square: nextSquare)
        } else if position == "B" {
            jumpI = squareBottomIndex(square: nextSquare)
            jumpJ += squareLeftIndex(square: nextSquare)
        } else if position == "L" {
            jumpI += squareTopIndex(square: nextSquare)
            jumpJ = squareLeftIndex(square: nextSquare)
        } else {
            jumpI += squareTopIndex(square: nextSquare)
            jumpJ = squareRightIndex(square: nextSquare)
        }


        if map[jumpI][jumpJ] == "#" {
            return false
        } else if map[jumpI][jumpJ] == "." {
            positionI = jumpI
            positionJ = jumpJ

            if position == "T" {
                facing = .Down
            } else if position == "B" {
                facing = .Up
            } else if position == "L" {
                facing = .Right
            } else {
                facing = .Left
            }

            return true
        }

        print ("Huh, how did you get there?")
        return false
    }

    func walk(hint: [[Hint]], visualize: Bool) {
        for direction in directions {
            if let steps = Int(direction) {
                var stepI = 0
                var stepJ = 0

                for _ in 0..<steps {
                    switch facing {
                    case .Up:
                        stepI = -1
                        stepJ = 0
                    case .Left:
                        stepI = 0
                        stepJ = -1
                    case .Down:
                        stepI = 1
                        stepJ = 0
                    case .Right:
                        stepI = 0
                        stepJ = 1
                    }

                    let squareI = positionI / squareHeight
                    let squareJ = positionJ / squareWidth
                    let currentSquare = squaresPerRow * squareI + squareJ

                    var futureSquareI = (positionI + stepI) / squareHeight
                    if positionI + stepI < 0 {
                        futureSquareI = -1
                    }

                    var futureSquareJ = (positionJ + stepJ) / squareWidth
                    if positionJ + stepJ < 0 {
                        futureSquareJ = -1
                    }

                    let futureSquare = squaresPerRow * futureSquareI + futureSquareJ

                    if currentSquare != futureSquare {
                        if !jumpToTheOtherSide(hint: hint) {
                            break
                        }
                    } else if map[positionI + stepI][positionJ + stepJ] == "#" {
                        break
                    } else if map[positionI + stepI][positionJ + stepJ] == "." {
                        positionI += stepI
                        positionJ += stepJ
                    } else {
                        print("Lost in the jungle")
                        return
                    }
                    if visualize {
                        show()
                    }
                }
            } else {
                facing.rotate(to: direction)
                if visualize {
                    show()
                }
            }
        }
    }
}
