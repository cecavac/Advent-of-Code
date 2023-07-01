//
//  FloorCounter.swift
//  Advent1
//
//  Created by Dragan Cecavac on 04.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class FloorCounter
{
    static func calculateFloors(for input: String) -> Int
    {
        var floor = 0

        for c in input {
            if c == "(" {
                floor += 1
            } else if c == ")" {
                floor -= 1
            } else {
                print("Error \(c)")
            }
        }

        return floor;
    }

    static func findFirstBasementIteration(for input: String) -> Int
    {
        var floor = 0
        var iteration = 1

        for c in input {
            if c == "(" {
                floor += 1
            } else if c == ")" {
                floor -= 1
            } else {
                print("Error \(c)")
            }

            if floor == -1 {
                break
            }

            iteration += 1
        }

        return iteration
    }
}
