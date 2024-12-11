//
//  PlutoPebble.swift
//  day-11
//
//  Created by Dragan Cecavac on 11.12.24.
//

import Darwin

class PlutoPebble {
    var stones = [Int:Int]()

    init(_ data: String) {
        for word in data.split(separator: " ") {
            let number = Int(String(word))!
            stones[number] = (stones[number] ?? 0) + 1
        }
    }

    func tick(count: Int) {
        for _ in 0..<count {
            tick()
        }
    }

    func tick() {
        var newStones = [Int:Int]()

        for (stone, amount) in stones {
            let digits = "\(stone)".count

            if stone == 0 {
                newStones[1] = (newStones[1] ?? 0) + amount
            } else if digits % 2 == 0 {
                let shift = Int(pow(10.0, Double(digits / 2)))

                let leftHalf = stone / shift
                newStones[leftHalf] = (newStones[leftHalf] ?? 0) + amount

                let rightHalf = stone % shift
                newStones[rightHalf] = (newStones[rightHalf] ?? 0) + amount
            } else {
                let newStone = stone * 2024
                newStones[newStone] = (newStones[newStone] ?? 0) + amount
            }
        }

        stones = newStones
    }

    var result: Int {
        return stones.values.reduce(0, +)
    }
}
