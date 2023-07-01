//
//  Rock.swift
//  Advent17
//
//  Created by Dragan Cecavac on 17.12.22.
//

import Foundation

struct Rock {
    var x = 2
    var y = 0
    var width = 0
    var height = 0

    var positions = Array(repeating: Array(repeating: Character(" "), count: 4), count: 4)

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for i in lines.indices {
            let elements = Array(String(lines[lines.count - i - 1]))
            for  j in elements.indices {
                if elements[j] == "#" {
                    positions[i][j] = elements[j]
                    width = max(width, j + 1)
                    height = max(height, i + 1)
                }
            }
        }
    }

    func canMoveLeft() -> Bool {
        return x > 0
    }

    func canMoveRight() -> Bool {
        return x + width < 7
    }

    mutating func moveLeft() {
        x -= 1
    }

    mutating func moveRight() {
        x += 1
    }

    mutating func moveUp() {
        y += 1
    }

    mutating func moveDown() {
        y -= 1
    }

    func colissionDetected(against other: Rock) -> Bool {
        let offsetI = abs(y - other.y)
        let offsetJ = abs(x - other.x)

        if offsetI >= 4 || offsetJ >= 4 {
            return false
        }

        for i in 0..<abs(4 - offsetI) {
            for j in 0..<abs(4 - offsetJ) {
                if x <= other.x && y <= other.y { //left and below
                    if positions[i + offsetI][j + offsetJ] == "#" && other.positions[i][j] == "#" {
                        return true
                    }
                } else if x <= other.x && y > other.y { //left and above
                    if positions[i][j + offsetJ] == "#" && other.positions[i + offsetI][j] == "#" {
                        return true
                    }
                } else if x > other.x && y <= other.y { //right and below
                    if positions[i + offsetI][j] == "#" && other.positions[i][j + offsetJ] == "#" {
                        return true
                    }
                } else { //right and above
                    if positions[i][j] == "#" && other.positions[i + offsetI][j + offsetJ] == "#" {
                        return true
                    }
                }
            }
        }

        return false
    }

    mutating func canMoveLeft(against other: Rock) -> Bool {
        if !canMoveLeft() {
            return false
        }

        // temporarily move, to simplify collision processing
        moveLeft()
        let result = colissionDetected(against: other)
        // move back to start
        moveRight()
        return !result
    }

    mutating func canMoveRight(against other: Rock) -> Bool {
        if !canMoveRight() {
            return false
        }

        // temporarily move, to simplify collision processing
        moveRight()
        let result = colissionDetected(against: other)
        // move back to start
        moveLeft()
        return !result
    }

    mutating func canMoveDown(against other: Rock) -> Bool {
        // temporarily move, to simplify collision processing
        moveDown()
        let result = colissionDetected(against: other)
        // move back to start
        moveUp()
        return !result
    }
}
