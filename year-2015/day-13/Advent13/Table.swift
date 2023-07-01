//
//  Table.swift
//  Advent13
//
//  Created by Dragan Cecavac on 26.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Table {
    var guests:[String] = []
    var preferences:[String:Int] = [:]
    var permutation:Permutation?

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            let words = line.split(separator: " ")
            let guest1 = words[0] + "."
            let guest2 = words[10]
            var happines = Int(words[3])!

            if words[2] == "lose" {
                happines = -happines
            }

            if !guests.contains(String(guest1)) {
                guests += [String(guest1)]
            }

            let key = String(guest1) + String(guest2)
            preferences[key] = happines
        }
    }

    func getScore(_ guestPermutation:[String]) -> Int {
        var result = 0

        for i in 0..<guestPermutation.count {
            let leftIndex = (i - 1 + guestPermutation.count) % guestPermutation.count
            let rightIndex = (i + 1) % guestPermutation.count

            let currentGuest = guestPermutation[i]
            let leftGuest = guestPermutation[leftIndex]
            let rightGuest = guestPermutation[rightIndex]

            result += preferences[currentGuest + leftGuest]!
            result += preferences[currentGuest + rightGuest]!
        }

        return result
    }

    func getBestScore() -> Int {
        permutation = Permutation(guests)

        var result = Int.min
        var guestPermutation = guests

        for _ in 0..<permutation!.limit {
            result = max(result,getScore(guestPermutation))
            guestPermutation = permutation!.next()
        }

        return result
    }

    func sit() {
        for guest in guests {
            let key1 = String(guest) + "me"
            let key2 = "me" + String(guest)
            preferences[key1] = 0
            preferences[key2] = 0
        }

        guests += ["me"]
    }
}
