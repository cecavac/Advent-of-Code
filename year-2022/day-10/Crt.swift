//
//  Crt.swift
//  Advent10
//
//  Created by Dragan Cecavac on 10.12.22.
//

import Foundation

class Crt {
    var instructions = [Instruction]()

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            instructions.append(Instruction(String(line)))
        }
    }

    private func drawPixel(cycle: Int, reg: Int) -> String {
        var draw: String

        if cycle % 40 == 0 {
            draw = "\n"
        } else {
            draw = ""
        }

        if abs(reg - (cycle % 40)) <= 1 {
            draw += "*"
        } else {
            draw += " "
        }

        return draw
    }

    func run() -> (Int, String) {
        var x = 1
        var ip = 0
        var result = 0
        let targetTicks = [20, 60, 100, 140, 180, 220]
        var line = ""

        for cycle in 0...240 {
            if cycle > 0 {
                if targetTicks.contains(cycle) {
                    result += x * cycle
                }

                if instructions[ip].tick(with: x) {
                    x = instructions[ip].result(using: x)
                    ip += 1
                }
            }

            line += drawPixel(cycle: cycle, reg: x)
        }

        return (result, line)
    }
}
