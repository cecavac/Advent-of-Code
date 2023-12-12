//
//  Row.swift
//  day-12
//
//  Created by Dragan Cecavac on 12.12.23.
//

import Foundation

class Row {
    let springs: [Character]
    let damaged: [Int]
    var cache = [String:Int]()

    init(_ input: String, unfold: Bool) {
        let sections = input.split(separator: " ")

        var springData = String(sections[0])
        if unfold {
            springData = "\(springData)?\(springData)?\(springData)?\(springData)?\(springData)"
        }
        springs = Array(springData)

        var damaged = [Int]()
        var damagedData = String(sections[1])
        if unfold {
            damagedData = "\(damagedData),\(damagedData),\(damagedData),\(damagedData),\(damagedData)"
        }

        let numbers = damagedData.split(separator: ",")
        for number in numbers {
            damaged.append(Int(String(number))!)
        }
        self.damaged = damaged
    }

    func possibilities(array: [Character]) -> Int {
        if !canBeValid(arrangement: array) {
            return 0
        }

        var hash = ""
        var canBeCached = false
        if let questionmarkIndex = array.firstIndex(of: "?") {
            if questionmarkIndex > 0 && array[questionmarkIndex - 1] == "." {
                canBeCached = true

                let countDamaged = array[0...questionmarkIndex].filter { $0 == "#" }.count
                hash = "\(countDamaged)\(questionmarkIndex)"
            }
        }

        if canBeCached {
            if let result = cache[hash] {
                return result
            }
        }

        var result = 0
        let questionMarkIndex = array.firstIndex(of: "?")
        if let index = questionMarkIndex {
            var damagedSpring = array
            damagedSpring[index] = "#"
            result += possibilities(array: damagedSpring)

            var operationalSpring = array
            operationalSpring[index] = "."
            result += possibilities(array: operationalSpring)
        } else {
            if isValid(arrangement: array) {
                return 1
            } else {
                return 0
            }
        }

        if canBeCached {
            cache[hash] = result
        }
        return result
    }

    func isValid(arrangement: [Character]) -> Bool {
        let damagedSections = String(arrangement).split(separator: ".")
        if damagedSections.count != damaged.count {
            return false
        }
        for i in damaged.indices {
            if damagedSections[i].count != damaged[i] {
                return false
            }
        }
        return true
    }

    func canBeValid(arrangement: [Character]) -> Bool {
        var mainSection = String(arrangement)

        if let questionmarkIndex = arrangement.firstIndex(of: "?") {
            mainSection = String(arrangement[0..<questionmarkIndex])
        }

        let damagedSections = mainSection.split(separator: ".")
        if damagedSections.count > damaged.count {
            return false
        }

        for i in 0..<damagedSections.count {
            if i == damagedSections.count - 1 {
                if damaged[i] < damagedSections[i].count {
                    return false
                }
            } else {
                if damaged[i] != damagedSections[i].count {
                    return false
                }
            }
        }

        return true
    }
}
