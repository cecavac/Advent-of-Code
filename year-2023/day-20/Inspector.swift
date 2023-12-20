//
//  Inspector.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.23.
//

import Foundation

class Inspector {
    var iteration = 0
    var penultimates = Set<String>()
    var firstOccurrence = [String:Int]()
    var secondOccurrence = [String:Int]()

    func insert(id: String) {
        penultimates.insert(id)
    }

    func check(id: String) {
        if penultimates.contains(id) {
            if firstOccurrence[id] == nil {
                firstOccurrence[id] = iteration
            } else if secondOccurrence[id] == nil {
                secondOccurrence[id] = iteration
            }
        }
    }

    func done() -> Bool {
        return penultimates.count == secondOccurrence.count
    }

    func tick() {
        iteration += 1
    }

    func value() -> Int {
        var result = 1
        for penultimate in penultimates {
            result *= secondOccurrence[penultimate]! - firstOccurrence[penultimate]!
        }
        return result
    }
}
