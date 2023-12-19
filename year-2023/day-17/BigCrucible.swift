//
//  BigCrucible.swift
//  day-17
//
//  Created by Dragan Cecavac on 17.12.23.
//

import Foundation

class BigCrucible: Crucible {
    init(_ input: String) {
        super.init(input, hashBase: 10)
    }

    override func checkConstraints(_ array: [Character]) -> Bool {
        if !super.checkConstraints(array) {
            return false
        }

        if array.count >= 5 {
            if array[array.count - 1] != array[array.count - 2] {
                for i in 3...5 {
                    if array[array.count - 2] != array[array.count - i] {
                        return false
                    }
                }
            }
        } else if array.count > 0 {
            for i in 0..<array.count {
                if array[i] != array.last! {
                    return false
                }
            }
        }

        return true
    }
}
