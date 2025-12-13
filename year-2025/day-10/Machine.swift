//
//  Machine.swift
//  day-10
//
//  Created by Dragan Cecavac on 10.12.25.
//

class Machine {
    private let buttons: Array<Array<Int>>
    private let joltage: Array<Int>
    private let targetStateHash: String

    private var minButtonScore = [String: Int]()
    private var joltageChanges = [String: Array<JoltageChange>]()

    init(_ data: String) {
        var elements = data.split(separator: " ")

        var state = Array(String(elements.removeFirst()))
        state.removeFirst()
        state.removeLast()
        targetStateHash = String(state)

        var joltString = String(elements.removeLast())
        joltString.removeFirst()
        joltString.removeLast()
        joltage = joltString.split(separator: ",")
            .map { Int(String($0))! }

        var buttons = [[Int]]()
        for element in elements {
            var currentElement = String(element)
            currentElement.removeFirst()
            currentElement.removeLast()
            let button = currentElement.split(separator: ",")
                .map { Int(String($0))! }
            buttons.append(button)
        }
        self.buttons = buttons

        exploreCombinations(buttonActions: [])
    }

    private func boolArrayToHash(_ array: Array<Bool>) -> String {
        var hash = ""
        for element in array {
            if element {
                hash += "#"
            } else {
                hash += "."
            }
        }
        return hash
    }

    private func exploreCombinations(buttonActions: Array<Bool>) {
        if buttonActions.count < buttons.count {
            exploreCombinations(buttonActions: buttonActions + [false])
            exploreCombinations(buttonActions: buttonActions + [true])
        } else {
            var state = Array(repeating: false, count: joltage.count)
            var joltageBump = Array(repeating: 0, count: joltage.count)
            for i in buttons.indices {
                if buttonActions[i] {
                    for j in buttons[i] {
                        state[j] = !state[j]
                        joltageBump[j] += 1
                    }
                }
            }

            let stateHash = boolArrayToHash(state)
            let buttonPresses = buttonActions.filter { $0 }.count
            minButtonScore[stateHash] = min(minButtonScore[stateHash] ?? Int.max, buttonPresses)

            let change = JoltageChange(bump: joltageBump, presses: buttonPresses)
            if joltageChanges[stateHash] == nil {
                joltageChanges[stateHash] = []
            }
            joltageChanges[stateHash]!.append(change)
        }
    }

    func indicatorPresses() -> Int {
        return minButtonScore[targetStateHash]!
    }

    private func joltagePresses(remainingJoltage: Array<Int>) -> Int? {
        var result: Int? = nil
        if remainingJoltage.reduce(0, +) == 0 {
            return 0
        }

        var trimmedJoltage = [Bool]()
        for currentJoltage in remainingJoltage {
            trimmedJoltage.append(currentJoltage % 2 == 1)
        }
        let trimmedJoltageHash = boolArrayToHash(trimmedJoltage)

        if joltageChanges[trimmedJoltageHash] == nil {
            return nil
        }
        for change in joltageChanges[trimmedJoltageHash]! {
            let newRemainingJoltage = joltage.indices.map {
                (remainingJoltage[$0] - change.bump[$0]) / 2
            }
            if newRemainingJoltage.filter({ $0 < 0 }).count > 0 {
                continue
            }

            if let buttonPresses = joltagePresses(remainingJoltage: newRemainingJoltage) {
                result = min(result ?? Int.max, buttonPresses * 2 + change.presses)
            }
        }

        return result
    }

    func joltagePresses() -> Int {
        return joltagePresses(remainingJoltage: joltage)!
    }
}
