//
//  Computer.swift
//  day-03
//
//  Created by Dragan Cecavac on 03.12.24.
//

class Computer {
    let data: String
    let instructions: Array<String>

    init(_ data: String) {
        self.data = data
        var instructions = Array<String>()
        let mulSearch = Regex(/mul\(\d+,\d+\)|do\(\)|don't\(\)/)
        for value in data.ranges(of: mulSearch) {
            let instruction = String(data[value])
            instructions.append(instruction)
        }
        self.instructions = instructions
    }

    private func mul(instruction: String) -> Int {
        let spacedInstruction = instruction.replacingOccurrences(of: "(", with: " ")
            .replacingOccurrences(of: ",", with: " ")
            .replacingOccurrences(of: ")", with: " ")
        let elements = spacedInstruction.split(separator: " ")

        let left = Int(String(elements[1]))!
        let right = Int(String(elements[2]))!
        return left * right
    }

    func allMultiplications() -> Int {
        return instructions.filter { $0.starts(with: "mul(") }
            .map { mul(instruction: $0) }
            .reduce(0, +)
    }

    func selectedMultiplications() -> Int {
        var result = 0
        var calculate = true

        for instruction in instructions {
            if instruction.starts(with: "do(") {
                calculate = true
            } else if instruction.starts(with: "don't(") {
                calculate = false
            } else if instruction.starts(with: "mul(") && calculate {
                result += mul(instruction: instruction)
            }
        }

        return result
    }
}
