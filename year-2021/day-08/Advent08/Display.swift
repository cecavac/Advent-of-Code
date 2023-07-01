//
//  Display.swift
//  Advent08
//
//  Created by Dragan Cecavac on 08.12.21.
//

import Foundation

class Display {
    var result1 = 0
    var result2 = 0

    init(_ input: String) {
        let displayDecoder = DisplayDecoder()
        let lines = input.split(separator: "\n")
        for line in lines {
            let components = line.split(separator: "|")
            let values = components[1].split(separator: " ")
            for value in values {
                let length = String(value).count
                if length == 2 || length == 3 || length == 4 || length == 7 {
                    result1 += 1
                }
            }

            result2 += displayDecoder.process(String(line))
        }
    }
}
