//
//  Onsen.swift
//  day-19
//
//  Created by Dragan Cecavac on 19.12.24.
//

class Onsen {
    let patterns: Array<String>
    let towels: Array<String>

    var result1 = 0
    var result2 = 0
    var attempts = Set<String>()
    var successAttempts: [String:Int] = [:]

    init(_ data: String) {
        let sections = data.split(separator: "\n\n")
        patterns = sections[0].split(separator: ", ")
            .map { String($0) }
        towels = sections[1].split(separator: "\n")
            .map { String($0) }
    }

    func find(towel: String, current: String) -> Int {
        var result = 0

        for pattern in patterns {
            let newCurrent = current + pattern

            if let additional = successAttempts[newCurrent] {
                result += additional
                continue
            }

            if attempts.contains(newCurrent) {
                continue
            } else {
                attempts.insert(newCurrent)
            }

            if towel == newCurrent {
                result += 1
                successAttempts[newCurrent] = 1
            }

            if towel.starts(with: newCurrent) {
                let newResult = find(towel: towel, current: newCurrent)
                if newResult > 0 {
                    successAttempts[newCurrent] = newResult
                }
                result += newResult
            }
        }

        return result
    }

    func find() {
        for towel in towels {
            attempts = Set<String>()
            successAttempts = [:]

            let result = find(towel: towel, current: "")
            if result > 0 {
                result1 += 1
                result2 += result
            }
        }
    }
}
