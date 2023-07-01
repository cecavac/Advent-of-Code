//
//  Monkeys.swift
//  Advent21
//
//  Created by Dragan Cecavac on 21.12.22.
//

import Foundation

class Monkeys {
    var operations = [String:Operation]()

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            let operation = Operation(String(line))
            operations[operation.id] = operation
        }
    }

    func getRoot() -> Int {
        while true {
            if let result = operations["root"]!.value {
                return result
            }

            for (_, operation) in operations {
                if operation.value == nil {
                    let operand1 = operations[operation.operand1!]!
                    let operand2 = operations[operation.operand2!]!
                    operation.calculate(value1: operand1.value, value2: operand2.value)
                }
            }
        }
    }

    private func findTarget() {
        operations["humn"]!.value = nil

        while true {
            if let root = operations["root"] {
                if operations[root.operand1!]!.value != nil ||
                    operations[root.operand2!]!.value != nil {
                    return
                }
            }

            for (key, operation) in operations {
                if key != "humn" && operation.value == nil {
                    let operand1 = operations[operation.operand1!]!
                    let operand2 = operations[operation.operand2!]!
                    operation.calculate(value1: operand1.value, value2: operand2.value)
                }
            }
        }
    }

    private func getHumnValue(operation: Operation, target: Int) -> Int? {
        if let value1 = operations[operation.operand1!]!.value {
            let newTarget = operation.calculateReverse(value1: value1, target: target)!
            if operation.operand2! == "humn" {
                return newTarget
            }

            return getHumnValue(operation: operations[operation.operand2!]!, target: newTarget)
        } else if let value2 = operations[operation.operand2!]!.value {
            let newTarget = operation.calculateReverse(value2: value2, target: target)!
            if operation.operand1! == "humn" {
                return newTarget
            }

            return getHumnValue(operation: operations[operation.operand1!]!, target: newTarget)
        } else {
            return nil
        }
    }

    func getHumn() -> Int? {
        findTarget()
        let root = operations["root"]!
        if let target = operations[root.operand1!]!.value {
            return getHumnValue(operation: operations[root.operand2!]!, target: target)
        } else if let target = operations[root.operand2!]!.value {
            return getHumnValue(operation: operations[root.operand1!]!, target: target)
        } else {
            print("Error: could not determine target")
            return nil
        }
    }
}
