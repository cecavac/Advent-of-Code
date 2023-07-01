//
//  Unscrambler.swift
//  Advent21
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Unscrambler: Scrambler {
    override init(do input: String, for pas: String) {
        var lines = input.split(separator: "\n")
        lines.reverse()

        var reversedInput = ""
        for line in lines {
            reversedInput += "\(line)\n"
        }

        super.init(do: reversedInput, for: pas)
    }

    override func rotate(basedOn x: Character) {
        let original = password

        for i in 0...password.count {
            password = original

            super.rotateLeft(by: i)
            super.rotate(basedOn: x)

            if password == original {
                rotateRight(by: i)
                return
            }
        }

        print("Error reverting rotation based on character")
    }

    override func rotateLeft(by n: Int) {
        super.rotateRight(by: n)
    }

    override func rotateRight(by n: Int) {
        super.rotateLeft(by: n)
    }

    override func move(x: Int, y: Int) {
        super.move(x: y, y: x)
    }
}
