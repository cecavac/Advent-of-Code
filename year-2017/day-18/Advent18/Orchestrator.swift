//
//  Orchestrator.swift
//  Advent18
//
//  Created by Dragan Cecavac on 12.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Orchestrator {
    public static func run(_ input: String) -> Int {
        let queue0 = FakeBlockingQueue()
        let queue1 = FakeBlockingQueue()

        let commBox0 = CommunicationBox(input, send: queue0, receive: queue1, id: 0)
        let commBox1 = CommunicationBox(input, send: queue1, receive: queue0, id: 1)

        var completed = false
        repeat {
            commBox0.tick()
            commBox1.tick()

            completed = (commBox0.done && commBox1.done) ||
                        (commBox0.locked && commBox1.done) ||
                        (commBox0.done && commBox1.locked) ||
                        (commBox0.locked && commBox1.locked)
        } while !completed

        return commBox1.sent
    }
}
