//
//  Factory.swift
//  Advent10
//
//  Created by Dragan Cecavac on 22.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Factory {
    struct Command {
        var instruction: String
        var executed = false
    }

    var bots:[Int:Set<Int>] = [:]
    var outputs:[Int:Set<Int>] = [:]

    private(set) var result1 = 0

    public var result2: Int {
        return outputs[0]!.first! * outputs[1]!.first! * outputs[2]!.first!
    }

    private func checkTarget1() {
        for (bot, contents) in bots {
            if contents.contains(17) && contents.contains(61) {
                result1 = bot
            }
        }
    }

    private func allExecuted(_ commands:[Command]) -> Bool {
        for command in commands {
            if !command.executed {
                return false
            }
        }

        return true
    }

    public func process(_ input: String) {
        var commands = Array<Command>()

        let lines = input.split(separator:"\n")
        for line in lines {
            commands.append(Command(instruction: String(line)))
        }

        while (!allExecuted(commands)) {
            for i in 0..<commands.count {
                let executed = instruction(commands[i].instruction)
                commands[i].executed = executed

                checkTarget1()
            }
        }
    }

    private func give(item value: Int, toBot botIndex: Int) {
        if bots[botIndex] == nil {
            bots[botIndex] = Set<Int>()
        }

        bots[botIndex]!.insert(value)
    }

    private func give(item value: Int, toOutput outputIndex: Int) {
        if outputs[outputIndex] == nil {
            outputs[outputIndex] = Set<Int>()
        }

        outputs[outputIndex]!.insert(value)
    }

    private func give(item value: Int, to type: String, with index: Int) {
        if type == "bot" {
            give(item: value, toBot: index)
        } else if type == "output" {
            give(item: value, toOutput: index)
        } else {
            print("Error receiver type: \(type)")
        }
    }

    private func instruction(_ input: String) -> Bool {
        let elements = input.split(separator: " ")

        if elements[0] == "bot" {
            let bot = Int(elements[1])!
            let low = Int(elements[6])!
            let high = Int(elements[11])!

            if bots[bot] == nil ||
                bots[bot]!.count < 2 {
                return false
            }

            var minV = Int.max
            var maxV = Int.min

            for content in bots[bot]! {
                minV = min(minV, content)
                maxV = max(maxV, content)
            }

            bots[bot]!.remove(minV)
            bots[bot]!.remove(maxV)

            give(item: minV, to: String(elements[5]), with: low)
            give(item: maxV, to: String(elements[10]), with: high)
        } else if elements[0] == "value" {
            let value = Int(elements[1])!
            let bot = Int(elements[5])!

            give(item: value, toBot: bot)
        } else {
            print("Error command: \(elements[0])")
        }

        return true
    }
}
