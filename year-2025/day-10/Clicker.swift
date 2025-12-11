//
//  Clicker.swift
//  day-10
//
//  Created by Dragan Cecavac on 10.12.25.
//

class Clicker {
    let machines: Array<Machine>
    let data: String

    init(_ data: String) {
        self.data = data
        machines = data.split(separator: "\n")
            .map { Machine(String($0)) }
    }

    func part1() -> Int {
        return machines.map { $0.fewestPressesToReachTheTarget() }.reduce(0, +)
    }

    func part2() -> Int {
        let pythonResult = Python.run(self.data)
        return Int(pythonResult)!
    }
}
