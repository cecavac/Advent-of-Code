//
//  Polymerization.swift
//  Advent14
//
//  Created by Dragan Cecavac on 14.12.21.
//

import Foundation

class Polymerization {
    var state = [Character]()
    var rules = [String:Character]()
    var cache = [String:String]()
    var options = Set<Character>()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        state = Array(String(lines[0]))

        for i in 1..<lines.count {
            let elements = lines[i].split(separator: " ")
            rules[String(elements[0])] = String(elements[2]).first!
            options.insert(String(elements[2]).first!)
        }
    }

    func tick() {
        var newState = [Character]()
        newState.append(state[0])
        for i in 1..<state.count {
            let section = "\(state[i - 1])\(state[i])"
            newState.append(rules[section]!)
            newState.append(state[i])
        }
        state = newState
    }

    func tick(count: Int) {
        for _ in 0..<count {
            tick()
        }
    }

    func train() {
        let originalState =  state
        for option1 in options {
            for option2 in options {
                state = [option1, option2]
                tick(count: 5)
                // cache all 5 step outcomes resulting from 2 characters
                cache["\(option1)\(option2)"] = String(state)
            }
        }
        state = originalState
    }

    func smartTick(count: Int) -> Int {
        let lastChar = state.last!

        // Map all the current pairs and track their frequency
        var abstractState = [String:Int]()
        for i in 1..<state.count {
            let section = "\(state[i - 1])\(state[i])"
            if let count = abstractState[section] {
                abstractState[section] = count + 1
            } else {
                abstractState[section] = 1
            }
        }

        // Iterate 5 steps a time
        for _ in 0..<(count / 5) {
            var newAbstractState = [String:Int]()
            for (subState, count) in abstractState {
                // Get the cached value and increase the new abstract state map for every new pair
                let subStateResult = Array(cache[subState]!)
                for i in 1..<subStateResult.count {
                    let section = "\(subStateResult[i - 1])\(subStateResult[i])"
                    if let value = newAbstractState[section] {
                        newAbstractState[section] = value + count
                    } else {
                        newAbstractState[section] = count
                    }
                }
            }
            abstractState = newAbstractState
        }

        var map:[Character:Int] = [:]
        for (subState, count) in abstractState {
            if let value = map[subState.first!] {
                map[subState.first!] = value + count
            } else {
                map[subState.first!] = count
            }
        }
        // To avoid overlapping, map first char of every pair
        // and add the last char of the original state, as
        // it will always remain the last character
        map[lastChar]! += 1

        var maximum = 0
        var minimum = Int.max
        for (_, count) in map {
            maximum = max(maximum, count)
            minimum = min(minimum, count)
        }

        return maximum - minimum
    }
}
