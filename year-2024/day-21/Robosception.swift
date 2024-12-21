//
//  Robosception.swift
//  day-21
//
//  Created by Dragan Cecavac on 21.12.24.
//

class Robosception {
    let numbers: [String]

    init(_ data: String) {
        numbers = data.split(separator: "\n")
            .map { String($0) }
    }

    func buildCombinations(data: [[String]], index: Int) -> [String] {
        var results = [String]()

        if index == data.count {
            results.append("")
        } else {
            let others = buildCombinations(data: data, index: index + 1)
            for current in data[index] {
                for other in others {
                    results.append(current + other)
                }
            }
        }

        return results
    }

    func buildSplitCombinations(combinations: [String]) -> [[String]] {
        var results = [[String]]()

        for combination in combinations {
            let result = combination.split(separator: "A")
                .map { String($0) + "A" }
            results.append(result)
        }

        return results
    }

    func sum(scale: Int) -> Int {
        var result = 0

        for number in numbers {
            var valueString = number
            valueString.removeLast()
            let value = Int(valueString)!

            let numeric = NumericRobot()
            let directional = DirectionalRobot()

            let packedCombinations = numeric.enter(number)
            let combinations = buildCombinations(data: packedCombinations, index: 0)
            let splitCombinations = buildSplitCombinations(combinations: combinations)

            var minCount = Int.max
            for splitCombination in splitCombinations {
                var oldMap:[String:Int] = [:]

                for section in splitCombination {
                    oldMap[section] = (oldMap[section] ?? 0) + 1
                }

                for _ in 0..<scale {
                    var newMap:[String:Int] = [:]
                    for (key, value) in oldMap {
                        let sections = directional.enter(key)
                        for section in sections {
                            newMap[section] = (newMap[section] ?? 0) + value
                        }
                    }
                    oldMap = newMap
                }

                var count = 0
                for (key, value) in oldMap {
                    count += value * key.count
                }
                minCount = min(minCount, count)
            }

            result += minCount * value
        }

        return result
    }
}
