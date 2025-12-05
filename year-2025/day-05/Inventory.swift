//
//  Inventory.swift
//  day-05
//
//  Created by Dragan Cecavac on 05.12.25.
//

class Inventory {
    let fresh: Array<(Int, Int)>
    let ingredients: Array<Int>

    init(_ data: String) {
        let sections = data.split(separator: "\n\n")
        fresh = sections[0].split(separator: "\n")
            .map { line in
                let elements = line.split(separator: "-")
                return (Int(String(elements[0]))!, Int(String(elements[1]))!)
            }

        ingredients = sections[1].split(separator: "\n")
            .map { Int(String($0))! }
    }

    func isFresh(ingredient: Int) -> Bool {
        for range in fresh {
            if range.0 <= ingredient && ingredient <= range.1 {
                return true
            }
        }
        return false
    }

    func countFresh() -> Int {
        return ingredients.filter { isFresh(ingredient: $0) }.count
    }

    func allFresh() -> Int {
        var result = 0
        var trimmedFresh: Array<(Int, Int)?> = fresh.map { $0 }

        // Iterate over all pairs.
        // This ~doubles the combinations, but simplifies comparing logic.
        for i in fresh.indices {
            for j in fresh.indices {
                if i == j {
                    continue
                }

                if let left = trimmedFresh[i], let right = trimmedFresh[j] {
                    // not intersecting
                    if left.1 < right.0 || right.1 < left.0 {
                        continue
                    }

                    // intersecting
                    if left.0 <= right.0 && right.0 <= left.1 {
                        if left.0 <= right.0 && right.1 <= left.1 {
                            // right range is fully contained and can be removed
                            trimmedFresh[j] = nil
                        } else {
                            // remove the overlap area from the right range
                            trimmedFresh[j]!.0 = left.1 + 1
                        }
                    }
                }
            }
        }

        for range in trimmedFresh {
            if let element = range {
                result += element.1 - element.0 + 1
            }
        }

        return result
    }
}
