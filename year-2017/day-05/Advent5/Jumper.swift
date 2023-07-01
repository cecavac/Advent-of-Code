//
//  Jumper.swift
//  Advent5
//
//  Created by Dragan Cecavac on 06.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Jumper {
    var ip = 0
    var instructions: [Int] = []

    init(_ input: String) {
        let elements = input.split(separator: "\n")
        for element in elements {
            instructions.append(Int(element)!)
        }
    }

    public func run() -> Int {
        var steps = 0

        while true {
            if ip < 0 || ip >= instructions.count {
                return steps
            } else {
                steps += 1
            }

            let nextIp = ip + instructions[ip]
            instructions[ip] += 1
            ip = nextIp
        }
    }

    public func weirdRun() -> Int {
        var steps = 0

        while true {
            if ip < 0 || ip >= instructions.count {
                return steps
            } else {
                steps += 1
            }

            let decrease = instructions[ip] >= 3
            let nextIp = ip + instructions[ip]

            if decrease {
                instructions[ip] -= 1
            } else {
                instructions[ip] += 1
            }
            ip = nextIp
        }
    }
}
