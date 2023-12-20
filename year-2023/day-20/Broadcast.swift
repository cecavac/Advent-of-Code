//
//  Broadcast.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.23.
//

import Foundation

class Broadcast: Module {
    override func tick() {
        super.tick()

        let signalReceived = received.removeLast().0
        for output in outputs {
            output.addSignalToQueue(signal: signalReceived, from: id)
        }
    }
}
