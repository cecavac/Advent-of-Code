//
//  wrapper.swift
//  Advent2
//
//  Created by Dragan Cecavac on 04.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Wrapper
{
    public static func getSurface(for input: String) -> Int {
        var result = 0
        let lines = input.split(separator: "\n")

        for line in lines {
            let elements = line.split(separator: "x")
            let sideA = Int(elements[0])! * Int(elements[1])!
            let sideB = Int(elements[0])! * Int(elements[2])!
            let sideC = Int(elements[1])! * Int(elements[2])!
            let minSide = min(min(sideA, sideB), sideC)
            let surface = sideA * 2 + sideB * 2 + sideC * 2 + minSide

            result += surface
        }
        
        return result
    }
    
    public static func getRibbonLength(for input: String) -> Int {
        var result = 0
        let lines = input.split(separator: "\n")

        for line in lines {
            let elements = line.split(separator: "x")
            let lengthA = Int(elements[0])! + Int(elements[1])!
            let lengthB = Int(elements[0])! + Int(elements[2])!
            let lengthC = Int(elements[1])! + Int(elements[2])!
            let minLength = min(min(lengthA, lengthB), lengthC)
            let volume = Int(elements[0])! * Int(elements[1])! * Int(elements[2])!
            let length = minLength * 2 + volume

            result += length
        }
        
        return result
    }
}
