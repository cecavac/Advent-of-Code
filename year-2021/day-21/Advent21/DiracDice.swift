//
//  DiracDice.swift
//  Advent21
//
//  Created by Dragan Cecavac on 21.12.21.
//

import Foundation

class DiracDice {
    public static let fields = 10

    var position1: Int
    var score1 = 0

    var position2: Int
    var score2 = 0

    var round = 0
    var die = 0

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        let elements1 = lines[0].split(separator: " ")
        position1 = Int(String(elements1.last!))! - 1

        let elements2 = lines[1].split(separator: " ")
        position2 = Int(String(elements2.last!))! - 1
    }

    func tick() {
        var move = 0
        for _ in 0..<3 {
            die += 1
            if die > 100 {
                die = 1
            }
            move += die
        }

        if round % 2 == 0 {
            position1 = (position1 + move) % DiracDice.fields
            score1 += position1 + 1
        } else {
            position2 = (position2 + move) % DiracDice.fields
            score2 += position2 + 1
        }

        round += 1
    }

    func play() -> Int {
        while score1 < 1000 && score2 < 1000 {
            tick()
        }

        if score1 >= 1000 {
            return round * 3 * score2
        } else {
            return round * 3 * score1
        }
    }
}
