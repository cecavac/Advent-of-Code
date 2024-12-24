//
//  Gate.swift
//  day-24
//
//  Created by Dragan Cecavac on 24.12.24.
//

class Gate: Hashable, Comparable {
    let id: Int
    let type: String
    let left: String
    let right: String
    var out: String

    static var id = 0

    static func < (lhs: Gate, rhs: Gate) -> Bool {
        lhs.out < rhs.out
    }

    static func == (lhs: Gate, rhs: Gate) -> Bool {
            return lhs.id == rhs.id
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(_ data: String) {
        let elements = data.split(separator: " ")
        left = String(elements[0])
        type = String(elements[1])
        right = String(elements[2])
        out = String(elements[4])

        id = Gate.id
        Gate.id += 1
    }

    func result(left: Bool, right: Bool) -> Bool {
        switch type {
        case "AND":
            return left && right
        case "OR":
            return left || right
        case "XOR":
            return (left && !right) || (!left && right)
        default:
            fatalError("Invalid type \(type)")
        }
    }
}
