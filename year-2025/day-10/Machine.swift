//
//  Machine.swift
//  day-10
//
//  Created by Dragan Cecavac on 10.12.25.
//

class Machine {
    let description: String

    var targetCache = [String: Int]()
    var minTargetDepth = Int.max

    let currentState: Array<Bool>
    let targetState: Array<Bool>
    let buttons: Array<Array<Int>>
    let joltage: Array<Int>

    init(_ data: String) {
        description = data
        var elements = data.split(separator: " ")

        var state = Array(String(elements.removeFirst()))
        state.removeFirst()
        state.removeLast()
        targetState = state.map { $0 == "#" }
        currentState = Array(repeating: false, count: state.count)

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
    }

    func exploreStates(current: Array<Bool>, depth: Int) {
        let stateHash = "\(current)"
        if let minDepth = targetCache[stateHash] {
            if minDepth <= depth {
                return
            }
        }

        targetCache[stateHash] = depth
        if current == targetState {
            minTargetDepth = depth
            return
        }

        if minTargetDepth <= depth {
            return
        }

        for button in buttons {
            var newCurrent = current
            for action in button {
                newCurrent[action] = !newCurrent[action]
            }

            exploreStates(current: newCurrent, depth: depth + 1)
        }
    }

    func fewestPressesToReachTheTarget() -> Int {
        exploreStates(current: currentState, depth: 0)
        return minTargetDepth
    }
}
