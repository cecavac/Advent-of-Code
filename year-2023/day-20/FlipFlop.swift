//
//  FlipFlop.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.23.
//

import Foundation

class FlipFlop: Module {
    var state = false

    override func tick() {
        super.tick()

        var lowReceived = false
        while received.count > 0 {
            let (signal, _) = received.removeFirst()
            if signal == false {
                lowReceived = true
            }
        }

        if lowReceived {
            state = !state

            for output in outputs {
                output.addSignalToQueue(signal: state, from: id)
            }
        }
    }
}
