//
//  Monkey.swift
//  Advent11
//
//  Created by Dragan Cecavac on 11.12.22.
//

import Foundation

class Monkey {
    var inspected = 0
    var items = [Int]()
    let operation: Operation
    var divisibility: Int
    var conditionTrue: Int
    var conditionFalse: Int

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        let itemElements = lines[1].split(separator: " ")

        for i in 2..<itemElements.count {
            var value = String(itemElements[i])
            if itemElements[i].contains(",") {
                value.removeLast()
            }
            items.append(Int(String(value))!)
        }

        operation = Operation(String(lines[2]))

        let divisibilityElements = lines[3].split(separator: " ")
        divisibility = Int(String(divisibilityElements[3]))!

        let conditionTrueElements = lines[4].split(separator: " ")
        conditionTrue = Int(String(conditionTrueElements[5]))!

        let conditionFalseElements = lines[5].split(separator: " ")
        conditionFalse = Int(String(conditionFalseElements[5]))!
    }

    private func give(item: Int) {
        items.append(item)
    }

    func inspect(monkeys: [Monkey], worryHandling: ((Int) -> Int)) {
        for item in items {
            inspected += 1
            let newItem = worryHandling(operation.process(value: item)!)
            if newItem % divisibility == 0 {
                monkeys[conditionTrue].give(item: newItem)
            } else {
                monkeys[conditionFalse].give(item: newItem)
            }
        }
        items.removeAll()
    }
}
