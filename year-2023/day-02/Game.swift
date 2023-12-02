//
//  Game.swift
//  day-02
//
//  Created by Dragan Cecavac on 02.12.23.
//

import Foundation

class Game {
    let id: Int
    var cubes = [String:Int]()

    init(_ input: String) {
        let sections = input.split(separator: ": ")
        let gameAndIdParse = sections[0].split(separator: " ")
        id = Int(String(gameAndIdParse[1]))!

        let data = sections[1]
            .replacingOccurrences(of: ";", with: "")
            .replacingOccurrences(of: ",", with: "")
            .split(separator: " ")
        for i in stride(from: 0, to: data.count, by: 2) {
            let color = String(data[i + 1])
            let value = Int(String(data[i]))!

            if let currentValue = cubes[color] {
                cubes[color] = max(currentValue, value)
            } else {
                cubes[color] = value
            }
        }
    }

    var isValid: Bool {
        return cubes["red"]! <= 12 && cubes["green"]! <= 13 && cubes["blue"]! <= 14
    }

    var power: Int {
        return cubes["red"]! * cubes["green"]! * cubes["blue"]!
    }
}
