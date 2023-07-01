//
//  Display.swift
//  Advent8
//
//  Created by Dragan Cecavac on 16.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Display {
    var pixels: [[String]]

    init(rows: Int, columns: Int) {
        pixels = Array(repeating: Array(repeating: " ", count: columns), count: rows)
    }

    public var litPixelCount: Int {
        get {
            var count = 0

            for i in 0..<pixels.count {
                for j in 0..<pixels[0].count {
                    if pixels[i][j] == "#" {
                        count += 1
                    }
                }
            }

            return count
        }
    }

    private func rect(data input: String) {
        let elements = input.split(separator: " ")
        let words = elements[1].split(separator: "x")
        let columns = Int(words[0])!
        let rows = Int(words[1])!

        for i in 0..<rows {
            for j in 0..<columns {
                pixels[i][j] = "#"
            }
        }
    }

    private func rotateRow(row i: Int, offset n: Int) {
        let tempArray = pixels[i]

        for j in 0..<tempArray.count {
            let offsetedJ = (j + n) % tempArray.count

            pixels[i][offsetedJ] = tempArray[j]
        }
    }

    private func rotateColumn(column j: Int, offset n: Int) {
        var tempArray: [String] = []

        for i in 0..<pixels.count {
            tempArray.append(pixels[i][j])
        }

        for i in 0..<tempArray.count {
            let offsetedI = (i + n) % tempArray.count

            pixels[offsetedI][j] = tempArray[i]
        }
    }

    private func rotate(data input: String) {
        let elements = input.split(separator: " ")
        let targetElements = elements[2].split(separator: "=")
        let target = Int(targetElements[1])!
        let offset = Int(elements[4])!

        if elements[1] == "column" {
            rotateColumn(column: target, offset: offset)
        } else if elements[1] == "row" {
            rotateRow(row: target, offset: offset)
        } else {
            print("Error rotation option: \(elements[1])")
        }
    }

    public func process(data input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let data = String(line)

            if line.prefix(4) == "rect" {
                rect(data: data)
            } else if line.prefix(6) == "rotate" {
                rotate(data: data)
            } else {
                print("Error instruction: \(data)")
            }
        }
    }

    public func show() {
        for i in 0..<pixels.count {
            var row = ""
            for j in 0..<pixels[0].count {
                row += pixels[i][j]
            }
            print(row)
        }
    }
}
