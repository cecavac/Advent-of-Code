//
//  Game.swift
//  day-02
//
//  Created by Dragan Cecavac on 02.12.23.
//

import Foundation

class Game {
    let id: Int
    var subsets = [Subset]()

    init(_ input: String) {
        let sections = input.split(separator: ": ")
        let gameAndIdParse = sections[0].split(separator: " ")
        id = Int(String(gameAndIdParse[1]))!

        let setData = sections[1].split(separator: ";")
        for subsetData in setData {
            let subset = Subset(String(subsetData))
            subsets.append(subset)
        }
    }

    func isValid() -> Bool {
        return subsets.filter { $0.isValid() }.count == subsets.count
    }

    func power() -> Int {
        var red = 0
        var green = 0
        var blue = 0

        for set in subsets {
            red = max(red, set.red)
            green = max(green, set.green)
            blue = max(blue, set.blue)
        }

        return red * green * blue
    }
}
