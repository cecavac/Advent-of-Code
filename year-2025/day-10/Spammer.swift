//
//  Spammer.swift
//  day-10
//
//  Created by Dragan Cecavac on 10.12.25.
//

class Spammer {
    let machines: Array<Machine>

    init(_ data: String) {
        machines = data.split(separator: "\n")
            .map { Machine(String($0)) }
    }

    func indicatorPresses() -> Int {
        return machines.map { $0.indicatorPresses() }.reduce(0, +)
    }

    func joltagePresses() -> Int {
        return machines.map { $0.joltagePresses() }.reduce(0, +)
    }
}
