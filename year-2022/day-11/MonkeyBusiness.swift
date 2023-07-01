//
//  MonkeyBusiness.swift
//  Advent11
//
//  Created by Dragan Cecavac on 11.12.22.
//

import Foundation

class MonkeyBusiness {
    var monkeys = [Monkey]()
    var commonDiv: Int = 1

    init(_ input: String) {
        let monkeyInput = input.split(separator: "\n\n")
        for section in monkeyInput {
            monkeys.append(Monkey(String(section)))
        }

        for monkey in monkeys {
            commonDiv *= monkey.divisibility
        }
    }

    private func run(cycles: Int, worryHandling: ((Int) -> Int)) -> Int {
        for _ in 0..<cycles {
            for monkey in monkeys {
                monkey.inspect(monkeys: monkeys, worryHandling: worryHandling)
            }
        }

        let sortedMonkeys = monkeys.sorted(by: { $0.inspected >= $1.inspected })
        return sortedMonkeys[0].inspected * sortedMonkeys[1].inspected
    }

    func normalRun() -> Int {
        let worryHandling:((Int) -> Int) = { return $0 / 3 }
        return run(cycles: 20, worryHandling: worryHandling)
    }

    func desperateRun() -> Int {
        let worryHandling:((Int) -> Int) = { return $0 % self.commonDiv }
        return run(cycles: 10000, worryHandling: worryHandling)
    }
}
