//
//  Captcha.swift
//  Advent1
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Captcha {
    let content: [Character]

    init(_ input: String) {
        content = Array(input)
    }

    public func getNextSum(shiftHalf useHalfwayOffset: Bool) -> Int {
        var offset: Int
        var sum = 0

        if useHalfwayOffset {
            offset = content.count / 2
        } else {
            offset = 1
        }

        for i in 0..<content.count {
            let nextIndex = (i + offset) % content.count
            if content[i] == content[nextIndex] {
                sum += Int(String(content[i]))!
            }
        }

        return sum
    }
}
