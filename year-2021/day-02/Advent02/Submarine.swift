//
//  Submarine.swift
//  Advent02
//
//  Created by Dragan Cecavac on 02.12.21.
//

import Foundation

class Submarine {
    var x = 0
    var y = 0

    init(_ input: String, withAim: Bool) {
        var aim = 0
        let lines = input.split(separator: "\n")
        for line in lines {
            let components = line.split(separator: " ")
            let value = Int(String(components[1]))!

            if withAim {
                if components[0] == "forward" {
                    x += value
                    y += value * aim
                } else if components[0] == "up" {
                    aim -= value
                } else if components[0] == "down" {
                    aim += value
                }
            } else {
                if components[0] == "forward" {
                    x += value
                } else if components[0] == "up" {
                    y -= value
                } else if components[0] == "down" {
                    y += value
                }
            }
        }
    }

    var result: Int {
        return x * y
    }
}
