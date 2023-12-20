//
//  Module.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.23.
//

import Foundation

class Module {
    static var inspector = Inspector()
    static var map = [String:Module]()
    static var lowCounter = 0
    static var highCounter = 0

    let id: String
    var inputs = [Module]()
    var outputs = [Module]()
    var outputIds = [String]()
    var ticked = false
    var lastSignal = true

    init(data: String) {
        let adaptedData = data
            .replacingOccurrences(of: "%", with: "")
            .replacingOccurrences(of: "&", with: "")
            .replacingOccurrences(of: "-> ", with: "")
            .replacingOccurrences(of: ",", with: "")

        let elements = adaptedData.split(separator: " ")
        id = String(elements[0])

        for i in 1..<elements.count {
            outputIds.append(String(elements[i]))
        }

        Module.map[id] = self
    }

    func setup() {
    }

    func connect() {
        for outputId in outputIds {
            if Module.map[outputId] == nil {
                // End module which wasn't initialized yet
                Module.map[outputId] = Module(data: outputId)
            }

            let output = Module.map[outputId]!

            outputs.append(output)
            output.inputs.append(self)
        }
    }

    func canTick() -> Bool {
        for input in inputs {
            if !input.ticked {
                return false
            }
        }

        return true
    }

    func tick() {
        ticked = true
    }

    func resetCycle() {
        ticked = false
    }

    var delayed = [(Bool, String)]()
    var received = [(Bool, String)]()
    func addSignalToQueue(signal: Bool, from: String) {
        if outputs.count > 0 {
            delayed.append((signal, from))
        }

        if signal {
            Module.highCounter += 1
        } else {
            Module.lowCounter += 1
            Module.inspector.check(id: id)
        }
    }

    func flush() {
        received = delayed
        delayed.removeAll()
    }
}
