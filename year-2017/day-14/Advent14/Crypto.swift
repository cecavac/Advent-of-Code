//
//  Crypto.swift
//  Advent10
//
//  Created by Dragan Cecavac on 10.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Crypto {
    var array = Array<Int>()
    var lengths = Array<Int>()

    init(_ input: String) {
        let elements = input.split(separator: ",")
        for element in elements {
            lengths.append(Int(String(element))!)
        }

        for i in 0..<256 {
            array.append(i)
        }
    }

    private func rotate(from start: Int, next elementsCount: Int) {
        var tmpArray = Array<Int>()

        for i in 0..<elementsCount {
            let index = (start + i) % array.count
            tmpArray.append(array[index])
        }

        tmpArray.reverse()

        for i in 0..<elementsCount {
            let index = (start + i) % array.count
            array[index] = tmpArray[i]
        }
    }

    public func transform(start: Int, skipSize: Int) -> (Int, Int) {
        var skip = skipSize
        var position = start

        for length in lengths {
            rotate(from: position, next: Int(length))

            position += Int(length) + skip
            skip += 1
        }

        return (position, skip)
    }

    public var result: Int {
        return array[0] * array[1]
    }
}
