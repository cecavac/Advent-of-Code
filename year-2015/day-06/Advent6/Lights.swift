//
//  Lights.swift
//  Advent6
//
//  Created by Dragan Cecavac on 13.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Lights {
    var lights: [[Int]] = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)

    func toggle(xStart i1: Int, yStart j1: Int, xEnd i2: Int, yEnd j2: Int) {
        for i in i1...i2 {
            for j in j1...j2 {
                if lights[i][j] == 0 {
                    lights[i][j] = 1
                } else if lights[i][j] == 1 {
                    lights[i][j] = 0
                } else {
                    print("Error value lights[\(i)][\(j)] = \(lights[i][j])")
                }
            }
        }
    }

    func setLight(xStart i1: Int, yStart j1: Int, xEnd i2: Int, yEnd j2: Int, state value: Int) {
        for i in i1...i2 {
            for j in j1...j2 {
                lights[i][j] = value
            }
        }
    }

    func turnOn(xStart: Int, yStart: Int, xEnd: Int, yEnd: Int) {
        setLight(xStart: xStart, yStart: yStart, xEnd: xEnd, yEnd: yEnd, state: 1)
    }

    func turnOff(xStart: Int, yStart: Int, xEnd: Int, yEnd: Int) {
        setLight(xStart: xStart, yStart: yStart, xEnd: xEnd, yEnd: yEnd, state: 0)
    }

    public func command(_ command: String) {
        let words = command.split(separator: " ")
        let firstCoordinateWord = words[words.count - 3]
        let secondCoordinateWord = words[words.count - 1]
        let firstCoordinateWordElements = firstCoordinateWord.split(separator: ",")
        let secondCoordinateWordElements = secondCoordinateWord.split(separator: ",")

        let xStart = Int(firstCoordinateWordElements[0])!
        let yStart = Int(firstCoordinateWordElements[1])!
        let xEnd = Int(secondCoordinateWordElements[0])!
        let yEnd = Int(secondCoordinateWordElements[1])!

        if command.starts(with: "turn on ") {
            turnOn(xStart: xStart, yStart: yStart, xEnd: xEnd, yEnd: yEnd)
        } else if command.starts(with: "turn off ") {
            turnOff(xStart: xStart, yStart: yStart, xEnd: xEnd, yEnd: yEnd)
        } else if command.starts(with: "toggle ") {
            toggle(xStart: xStart, yStart: yStart, xEnd: xEnd, yEnd: yEnd)
        } else {
            print("Error command \(command)")
        }
    }

    public var lightsOn: Int {
        var lightsOn = 0

        for i in 0..<1000 {
            for j in 0..<1000 {
                lightsOn += lights[i][j]
            }
        }

        return lightsOn
    }
}
