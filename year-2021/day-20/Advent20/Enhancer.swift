//
//  Enhancer.swift
//  Advent20
//
//  Created by Dragan Cecavac on 20.12.21.
//

import Foundation

class Enhancer {
    var algorithm = [Bool]()
    var pixels = Set<String>()
    var minI = 0
    var maxI = 0
    var minJ = 0
    var maxJ = 0
    var secondBias: Character

    func hash(i: Int, j: Int) -> String {
        return "\(i)#\(j)"
    }

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for character in lines[0] {
            algorithm.append(character == "#")
        }

        if algorithm[0] {
            secondBias = "#"
        } else {
            secondBias = "."
        }

        for i in 1..<lines.count {
            let row = Array(lines[i])
            for j in 0..<lines[i].count {
                if row[j] == "#" {
                    let hash = hash(i: i - 1, j: j)
                    pixels.insert(hash)
                }
            }
        }

        maxI = lines.count - 2
        maxJ = lines.last!.count  - 1
    }

    func valueAt(i: Int, j: Int, bias: Character) -> Int {
        var result = 0

        for i in (i - 1)...(i + 1) {
            for j in (j - 1)...(j + 1) {
                result *= 2
                let hash = hash(i: i, j: j)

                if i <= minI || i >= maxI || j <= minI || j >= maxJ {
                    if bias == "#" {
                        result += 1
                    }
                } else {
                    if pixels.contains(hash) {
                        result += 1
                    }
                }
            }
        }

        return result
    }

    func process(ticks: Int) {
        for i in 0..<ticks {
            if i % 2 == 0 {
                process(bias: ".")
            } else {
                process(bias: secondBias)
            }
        }
    }

    func process(bias: Character) {
        minI -= 1
        maxI += 1
        minJ -= 1
        maxJ += 1

        var newPixels = Set<String>()

        for i in minI...maxI {
            for j in minJ...maxJ {
                let value = valueAt(i: i, j: j, bias: bias)
                if algorithm[value] {
                    let hash = hash(i: i, j: j)
                    newPixels.insert(hash)
                }
            }
        }

        pixels = newPixels
    }
}
