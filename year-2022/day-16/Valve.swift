//
//  Valve.swift
//  Advent16
//
//  Created by Dragan Cecavac on 16.12.22.
//

import Foundation

class Valve {
    let id: String
    let flow: Int
    var downstream = [Valve]()
    var upstream = [Valve]()

    init(id: String, flow: Int) {
        self.id = id
        self.flow = flow
    }

    static func parse(_ input: String) -> [String] {
        var adjustedInput = input.replacing("=", with: " ")
        adjustedInput = adjustedInput.replacing(";", with: "")
        adjustedInput = adjustedInput.replacing(",", with: "")
        let parsedInput = adjustedInput.split(separator: " ")
        return parsedInput.map{ String($0) }
    }

    func addUpstream(valve: Valve) {
        upstream.append(valve)
    }

    func addDownstream(valve: Valve) {
        downstream.append(valve)
    }
}
