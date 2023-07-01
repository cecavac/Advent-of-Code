//
//  Picture.swift
//  Advent21
//
//  Created by Dragan Cecavac on 16.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Picture {
    var pixels = Array(repeating: Array(repeating: Character("#"), count: 3), count: 3)
    var rules: [Rule] = []

    init (_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let rule = Rule(String(line))
            rules.append(rule)
        }

        pixels[0][0] = "."
        pixels[0][2] = "."
        pixels[1][0] = "."
        pixels[1][1] = "."
    }

    private func grow() {
        var step = -1
        var newSize = -1

        if pixels.count % 2 == 0 {
            step = 2
            newSize = (pixels.count / 2) * 3
        } else if pixels.count % 3 == 0 {
            step = 3
            newSize = (pixels.count / 3) * 4
        } else {
            print("Bad picture array size \(pixels.count)")
        }

        let superStep = step + 1
        var newArray = Array(repeating: Array(repeating: Character(" "), count: newSize), count: newSize)

        for i in 0..<(pixels.count / step) {
            for j in 0..<(pixels.count / step) {
                var subArray: [[Character]] = []
                var matchingArray: [[Character]] = []

                for ii in i * step..<(i + 1) * step {
                    var row: [Character] = []
                    for jj in j * step..<(j + 1) * step {
                        row.append(pixels[ii][jj])
                    }
                    subArray.append(row)
                }

                for rule in rules {
                    if rule.isMatching(subArray) {
                        matchingArray = rule.outputArray
                        break
                    }
                }

                for ii in 0..<superStep {
                    for jj in 0..<superStep {
                        let naI = i * superStep + ii
                        let naJ = j * superStep + jj
                        newArray[naI][naJ] = matchingArray[ii][jj]
                    }
                }
            }
        }

        pixels = newArray
    }

    public func generate(for iterations: Int) -> Int {
        var result = 0

        for i in 0..<iterations {
            //print("Running growth iteration: \(i + 1)")
            grow()
            //printArray()
        }

        for row in pixels {
            for pixel in row {
                if pixel == "#" {
                    result += 1
                }
            }
        }

        return result
    }

    private func printArray() {
        print("=========")

        for row in pixels {
            var result = ""

            for char in row {
                result += String(char)
            }

            print(result)
        }
    }
}
