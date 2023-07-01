//
//  Comparator.swift
//  Advent15
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Comparator {
    struct Generator {
        var value: Int
        let factor: Int

        mutating func nextValue() {
            value *= factor
            value %= 2147483647
        }
    }

    var genA: Generator
    var genB: Generator

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        let elementsA = lines[0].split(separator: " ")
        let elementsB = lines[1].split(separator: " ")

        genA = Generator(value: Int(String(elementsA[4]))!, factor: 16807)
        genB = Generator(value: Int(String(elementsB[4]))!, factor: 48271)
    }

    public func getMatches() -> Int {
        var matches = 0

        for i in 0..<40000000 {
            let valueA = genA.value & 0xffff
            let valueB = genB.value & 0xffff

            if valueA == valueB {
                matches += 1
            }

            genA.nextValue()
            genB.nextValue()
        }

        return matches
    }

    public func getSpecialMatches() -> Int {
        var matches = 0

        for i in 0..<5000000 {
            let valueA = genA.value & 0xffff
            let valueB = genB.value & 0xffff

            if valueA == valueB {
                matches += 1
            }

            genA.nextValue()
            while genA.value % 4 != 0 {
                genA.nextValue()
            }

            genB.nextValue()
            while genB.value % 8 != 0 {
                genB.nextValue()
            }
        }

        return matches
    }
}
