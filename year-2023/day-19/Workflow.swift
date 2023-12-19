//
//  Workflow.swift
//  day-19
//
//  Created by Dragan Cecavac on 19.12.23.
//

import Foundation

struct Workflow {
    let name: String
    var rules = [Rule]()

    init(_ input: String) {
        let adapted = input.replacingOccurrences(of: "{", with: " ")
            .replacingOccurrences(of: "}", with: "")
            .replacingOccurrences(of: ",", with: " ")
        let elements = adapted.split(separator: " ")

        name = String(elements[0])
        for i in 1..<elements.count {
            rules.append(Rule(String(elements[i])))
        }
    }

    func check(item: Item) -> String? {
        for rule in rules {
            if let result = rule.check(item: item) {
                return result
            }
        }

        return nil
    }

    func destinations() -> [String] {
        var result = [String]()
        for rule in rules {
            result.append(rule.last)
        }
        return result
    }
}

