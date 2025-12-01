//
//  Safe.swift
//  day-01
//
//  Created by Dragan Cecavac on 01.12.25.
//

class Safe {
    let moves: Array<Int>

    var dial = 50
    var zero = 0
    var rollingZero = 0

    init(_ data: String) {
        moves = data.split(separator: "\n").map {
            var characters = Array(String($0))

            let sign: Int
            if characters[0] == "R" {
                sign = 1
            } else {
                sign = -1
            }

            characters.remove(at: 0)
            let count = Int(String(characters))!
            return sign * count
        }
    }

    func unlock() {
        for move in moves {
            let previousDial = dial

            dial = (dial + move) % 100
            if dial < 0 || dial >= 100 {
                dial = (dial + 100) % 100
            }

            let spins = abs(move) / 100
            rollingZero += spins

            if dial == 0 {
                zero += 1
                rollingZero += 1
            } else {
                if (move < 0 && previousDial != 0 && previousDial < dial)
                    || (move > 0 && dial != 0 && previousDial > dial) {
                    rollingZero += 1
                }
            }
        }
    }
}
