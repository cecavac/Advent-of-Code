//
//  Computer.swift
//  day-17
//
//  Created by Dragan Cecavac on 17.12.24.
//

import Darwin

class Computer {
    var a: Int
    var b: Int
    var c: Int
    var instructions: [Int]
    let input: String

    init(_ data: String) {
        input = data
        let sections = data.split(separator: "\n")
        a = Int(String(sections[0].split(separator: " ")[2]))!
        b = Int(String(sections[1].split(separator: " ")[2]))!
        c = Int(String(sections[2].split(separator: " ")[2]))!

        let program = sections[3].split(separator: " ")
        instructions = program[1].split(separator: ",")
            .map { Int(String($0))! }
    }

    func fastRun() -> String {
        var result = ""

        // Fine-tuned for my custom input
        while true {
            // 2,4
            b = a % 8

            // 1,1
            b = b ^ 1

            // 7,5
            c = a / 2 << (b - 1)

            // 1,5
            b = b ^ 5

            // 4,0
            b = b ^ c

            // 5,5
            if result != "" {
                result += ","
            }
            result += "\(b % 8)"

            // 0,3
            a /= 8

            // 3,0
            if a == 0 {
                break
            }
        }

        return result
    }

    func selfOutput() -> Int {
        var result = 0
        var target = ""

        for instruction in instructions.reversed() {
            if target != "" {
                target = "," + target
            }
            target = "\(instruction)" + target

            result <<= 3
            for j in result...(result + 64) {
                let computer = Computer(input)
                computer.a = j
                if computer.fastRun() == target {
                    result = j
                    break
                }
            }
        }

        return result
    }
}
