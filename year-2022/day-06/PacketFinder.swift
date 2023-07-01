//
//  PacketFinder.swift
//  Advent06
//
//  Created by Dragan Cecavac on 06.12.22.
//

import Foundation

class PacketFinder {
    public static func find(_ input: String, length: Int) -> Int? {
        let array = Array(input)

        for i in length...input.count {
            let window = array[i - length..<i]
            let set = Set<Character>(window)
            if set.count == length {
                return i
            }
        }

        return nil
    }
}
