//
//  visitTracker.swift
//  Advent3
//
//  Created by Dragan Cecavac on 05.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

public class VisitTracker
{
    var map: [Int64:Int64] = [:]
    var positionI: Int64 = 1000000
    var positionJ: Int64 = 1000000
    var positionHash: Int64 {
        return positionI * 1000000 + positionJ
    }

    func visitCurrent() {
        if let visits = map[positionHash] {
            map[positionHash] = visits + 1
        } else {
            map[positionHash] = 1
        }
    }

    public func visitedHousesCount(for input: String) -> Int {
        visitCurrent()

        for character in input {
            switch(character) {
            case "^":
                positionI -= 1
            case "v":
                positionI += 1
            case "<":
                positionJ -= 1
            case ">":
                positionJ += 1
            default:
                print("Error case: \(character)")
            }

            visitCurrent()
        }

        return map.count
    }
}
