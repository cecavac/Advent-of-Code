//
//  WireTracker.swift
//  Advent7
//
//  Created by Dragan Cecavac on 15.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class WireTracker {
    private var values: [String: UInt16] = [:]
    private var formulas: [Formula] = []

    public convenience init(for input: String, change key: String, with value: UInt16) {
        self.init(for: input)
        values[key] = value
    }

    public init(for input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            if let formula = Formula(for: String(line)) {
                formulas.append(formula)
                if let value = formula.value {
                    values[formula.output] = value
                }

                // Workaround for unexpected direct inputs
                if formula.inputs.count > 0 {
                    if let value = UInt16(formula.inputs[0]) {
                        values[formula.inputs[0]] = value
                    }
                    if formula.inputs.count > 1 {
                        if let value = UInt16(formula.inputs[1]) {
                            values[formula.inputs[1]] = value
                        }
                    }
                }
            }
        }
    }

    public func spin() {
        var change: Bool

        repeat {
            change = false

            for formula in formulas {
                if formula.value == nil {
                    change = change || formula.calculate(values)
                    if let value = formula.value {
                        values[formula.output] = value
                    }
                }
            }
        } while change == true
    }

    public func printz() {
        dump(values)
    }

    public func get(element key:String) -> UInt16? {
        return values[key]
    }
}
