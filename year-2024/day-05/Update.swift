//
//  Update.swift
//  day-05
//
//  Created by Dragan Cecavac on 05.12.24.
//

class Update {
    private var rules: [(Int, Int)]
    private let updates: [[Int]]
    private(set) var result1 = 0
    private(set) var result2 = 0

    init(_ input: String) {
        let sections = input.split(separator: "\n\n")

        rules = sections[0].split(separator: "\n")
            .map {
                let elements = $0.split(separator: "|")
                return (Int(String(elements[0]))!, Int(String(elements[1]))!)
            }

        updates = sections[1].split(separator: "\n")
            .map { updateData in
                updateData.split(separator: ",")
                    .map { Int(String($0))! }
            }

        process()
    }

    private func getMiddleIfValid(update: [Int]) -> Int? {
        for rule in rules {
            if let first = update.firstIndex(of: rule.0),
               let second = update.firstIndex(of: rule.1) {
                if first > second {
                    return nil
                }
            }
        }

        return update[update.count / 2]
    }

    private func compare(left: Int, right: Int) -> Bool {
        for rule in rules {
            if left == rule.0 && right == rule.1 {
                return true
            }
            if left == rule.1 && right == rule.0 {
                return false
            }
        }
        return true
    }

    private func process() {
        for update in updates {
            if let middle = getMiddleIfValid(update: update) {
                result1 += middle
            } else {
                let sortedUpdate = update.sorted { compare(left: $0, right: $1) }
                result2 += getMiddleIfValid(update: sortedUpdate)!
            }
        }
    }
}
