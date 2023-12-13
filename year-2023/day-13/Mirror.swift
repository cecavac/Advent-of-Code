//
//  Mirror.swift
//  day-13
//
//  Created by Dragan Cecavac on 13.12.23.
//

import Foundation

class Mirror {
    var pixels = [[Character]]()
    let width: Int
    let height: Int
    var lastResult: String? = nil

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            pixels.append(Array(String(line)))
        }
        width = pixels[0].count
        height = pixels.count
    }

    func sameRows(i1: Int, i2: Int) -> Bool {
        for j in 0..<width {
            if pixels[i1][j] != pixels[i2][j] {
                return false
            }
        }
        return true
    }

    func sameColumns(j1: Int, j2: Int) -> Bool {
        for i in 0..<height {
            if pixels[i][j1] != pixels[i][j2] {
                return false
            }
        }
        return true
    }

    func findHorizontalReflection() -> Int? {
        for base in (0...(height - 1)) {
            // compare with bottom rows
            var equal = true
            var i2 = base + 1
            for i in (0...base).reversed() {
                if i2 >= height {
                    if i2 == base + 1 {
                        equal = false
                    }
                    break
                }
                if !sameRows(i1: i, i2: i2) {
                    equal = false
                    break
                }
                i2 += 1
            }
            if equal {
                let result = (base + 1) * 100
                let combinedFormat = "h\(result)"
                if lastResult == nil || lastResult! != combinedFormat {
                    lastResult = combinedFormat
                    return result
                }
            }
        }

        return nil
    }

    func findVerticalReflection() -> Int? {
        for base in (0...(width - 1)) {
            // compare with right rows
            var equal = true
            var j2 = base + 1
            for j in (0...base).reversed() {
                if j2 >= width {
                    if j2 == base + 1 {
                        equal = false
                    }
                    break
                }
                if !sameColumns(j1: j, j2: j2) {
                    equal = false
                    break
                }
                j2 += 1
            }
            if equal {
                let result = base + 1
                let combinedFormat = "v\(result)"
                if lastResult == nil || lastResult! != combinedFormat {
                    lastResult = combinedFormat
                    return result
                }
            }
        }

        return nil
    }

    func flip(_ i: Int, _ j: Int) {
        if pixels[i][j] == "#" {
            pixels[i][j] = "."
        } else {
            pixels[i][j] = "#"
        }
    }

    func reflections() -> Int? {
        if let h1 = findHorizontalReflection() {
            return h1
        }
        if let v1 = findVerticalReflection() {
            return v1
        }

        return nil
    }

    func smudgeReflections() -> Int? {
        for i in 0..<height {
            for j in 0..<width {
                flip(i, j)

                if let result = findHorizontalReflection() {
                    return result
                }
                if let result = findVerticalReflection() {
                    return result
                }

                flip(i, j)
            }
        }

        return nil
    }
}
