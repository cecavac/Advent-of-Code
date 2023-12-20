//
//  Conjunction.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.23.
//

import Foundation

class Conjunction: Module {
    var inputStates = [String:Bool]()

    override func setup() {
        for input in inputs {
            inputStates[input.id] = false
        }
    }

    override func tick() {
        super.tick()

        while received.count > 0 {
            let (signal, from) = received.removeLast()
            inputStates[from] = signal

            var allHigh = true
            for inputState in inputStates.values {
                allHigh = allHigh && inputState
            }

            for output in outputs {
                output.addSignalToQueue(signal: !allHigh, from: id)
            }
        }
    }
}
