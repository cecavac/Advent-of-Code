//
//  Circuit.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.23.
//

import Foundation

class Circuit {
    var modules = [Module]()
    var broadcaster: Broadcast? = nil

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            let data = String(line)
            if data.starts(with: "broadcaster") {
                broadcaster = Broadcast(data: data)
                modules.append(broadcaster!)
            } else if data.starts(with: "&") {
                let conjunction = Conjunction(data: data)
                modules.append(conjunction)
            } else if data.starts(with: "%") {
                let flipFlop = FlipFlop(data: data)
                modules.append(flipFlop)
            } else {
                fatalError("Unknown")
            }
        }

        var finalModule: Module? = nil
        for module in modules {
            module.connect()

            for output in module.outputs {
                if output.id == "rx" {
                    finalModule = module
                }
            }
        }

        for module in modules {
            module.setup()

            // Collect penultimate elements
            for output in module.outputs {
                if output.id == finalModule!.id {
                    Module.inspector.insert(id: module.id)

                }
            }
        }
    }

    func smallTick() {
        for module in modules {
            module.resetCycle()
        }

        for module in modules {
            if module.received.count > 0 {
                module.tick()
            }
        }
    }

    func bigTick() {
        while true {
            smallTick()

            var allFinished = true
            for module in modules {
                module.flush()
                allFinished = allFinished && module.received.count == 0
            }
            if allFinished {
                break
            }
        }
    }

    func cycle() -> Int {
        for _ in 0..<1000 {
            broadcaster!.addSignalToQueue(signal: false, from: "button")
            broadcaster!.flush()

            bigTick()
        }

        return Module.highCounter * Module.lowCounter
    }

    func rxCycle() -> Int {
        while !Module.inspector.done() {
            Module.inspector.tick()
            broadcaster!.addSignalToQueue(signal: false, from: "button")
            broadcaster!.flush()
            bigTick()
        }

        return Module.inspector.value()
    }
}
