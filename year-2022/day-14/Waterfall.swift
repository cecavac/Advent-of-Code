//
//  Waterfall.swift
//  Based on: Advent of Code 2018 Day 17
//
//  Created by Dragan Cecavac on 21.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Waterfall {
    var minJ = 500
    var maxJ = 500
    var minI = 0
    var maxI = 0
    var minInputI = Int.max
    var supported = false

    var positionI = 0
    var positionJ = 500

    var map:[Int:Character] = [:]

    private func hash(i: Int, j: Int) -> Int {
        return i * 1000000 + j
    }

    private func getElement(i: Int, j: Int) -> Character {
        let hashVal = hash(i: i, j: j)
        if let result = map[hashVal] {
            return result
        } else {
            return "."
        }
    }

    private func setElement(i: Int, j: Int, value: Character) {
        let hashVal = hash(i: i, j: j)
        map[hashVal] = value
    }

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let simplerLine = String(line).replacingOccurrences(of: " -> ", with: " ")
            let elements = simplerLine.split(separator: " ")

            for k in 1..<elements.count {
                let base = elements[k - 1].split(separator: ",")
                let baseJ = Int(base[0])!
                let baseI = Int(base[1])!

                let end = elements[k].split(separator: ",")
                let endJ = Int(end[0])!
                let endI = Int(end[1])!

                var rangeI: ClosedRange<Int>
                if baseI < endI {
                    rangeI = baseI...endI
                } else {
                    rangeI = endI...baseI
                }
                var rangeJ: ClosedRange<Int>
                if baseJ < endJ {
                    rangeJ = baseJ...endJ
                } else {
                    rangeJ = endJ...baseJ
                }

                for i in rangeI {
                    for j in rangeJ {
                        setElement(i: i, j: j, value: "#")
                        minI = min(minI, i)
                        maxI = max(maxI, i)
                        minJ = min(minJ, j)
                        maxJ = max(maxJ, j)
                    }
                }
            }
        }

        setElement(i: 0, j: 500, value: "+")
    }

    public func show() {
        for i in minI...maxI {
            var row = ""
            for j in minJ...maxJ {
                row += String(getElement(i: i, j: j))
            }
            print(row)
        }
    }

    public var sandCount: Int {
        var result1 = 0

        for i in minI...maxI {
            for j in minJ...maxJ {
                if getElement(i: i, j: j) == "O" {
                    result1 += 1
                }
            }
        }

        return result1
    }

    func flow() {
        while true {
            var i = 0
            var j = 500
            var changed = true

            setElement(i: i, j: j, value: "O")
            while i <= maxI {
                if i == maxI {
                    setElement(i: i, j: j, value: ".")
                    changed = false
                    break
                } else if getElement(i: i + 1, j: j) == "." {
                    setElement(i: i, j: j, value: ".")
                    i += 1
                    setElement(i: i, j: j, value: "O")
                } else if getElement(i: i + 1, j: j) == "#" || getElement(i: i + 1, j: j) == "O" {
                    if getElement(i: i + 1, j: j - 1) == "." {
                        setElement(i: i, j: j, value: ".")
                        i += 1
                        j -= 1
                        setElement(i: i, j: j, value: "O")
                    } else if getElement(i: i + 1, j: j + 1) == "." {
                        setElement(i: i, j: j, value: ".")
                        i += 1
                        j += 1
                        setElement(i: i, j: j, value: "O")
                    } else {
                        break
                    }
                } else {
                    break
                }
            }

            if (!supported && !changed) ||
                (supported && getElement(i: 0, j: 500) == "O") {
                break
            }
        }
    }

    func support() {
        supported = true

        let extraWidth = maxI - minI + 2
        minJ -= extraWidth
        maxJ += extraWidth
        maxI += 2

        for j in minJ...maxJ {
            setElement(i: maxI, j: j, value: "#")
        }
    }
}
