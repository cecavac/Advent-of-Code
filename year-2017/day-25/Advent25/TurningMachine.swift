//
//  TurningMachine.swift
//  Advent25
//
//  Created by Dragan Cecavac on 18.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class TuringMachine {
    var tape: [Int:Int] = [:]
    var ip = 0
    var state: String
    var states: [String:Neuron] = [:]
    var steps: Int

    init(_ input: String) {
        var cleanInput = ""
        for char in input {
            if char != "." && char != ":" && char != "-" {
                cleanInput += String(char)
            }
        }

        let lines = cleanInput.split(separator: "\n")
        let row0 = Array<Character>(String(lines[0]))
        state = String(row0.last!)

        let row2 = lines[1].split(separator: " ")
        steps = Int(String(row2[5]))!

        var i = 2
        while i < lines.count {
            let stateName = String(lines[i].last!)

            var neuronInput = ""
            for _ in 0..<8 {
                i += 1
                neuronInput += lines[i] + "\n"
            }
            i += 1

            let neuron = Neuron(neuronInput)
            states[stateName] = neuron
        }
    }

    public func run() -> Int {
        var result = 0

        for _ in 0..<steps {
            var value: Int

            if  tape[ip] != nil {
                value = tape[ip]!
            } else {
                value = 0
            }

            let neuron = states[state]!
            var newValue = -1
            var goRight = false
            var newState = ""

            if value == 0 {
                newValue = neuron.valueWhen0
                goRight = neuron.goRightWhen0
                newState = neuron.stateWhen0

                if newValue == 1 {
                    result += 1
                }
            } else if value == 1 {
                newValue = neuron.valueWhen1
                goRight = neuron.goRightWhen1
                newState = neuron.stateWhen1

                if newValue == 0 {
                    result -= 1
                }
            } else {
                print("Error value \(value)")
            }

            tape[ip] = newValue

            if goRight {
                ip += 1
            } else {
                ip -= 1
            }

            state = newState
        }

        return result
    }
}
