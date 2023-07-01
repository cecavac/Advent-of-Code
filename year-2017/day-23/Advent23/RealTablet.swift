//
//  RealTablet.swift
//  Advent23
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class RealTablet {
    var b = 0
    var c = 0
    var h = 0

    private func isPrime(_ n: Int) -> Bool {
        if n <= 1 {
            return false
        }

        if n <= 3 {
            return true
        }

        for i in 2...(n / 2) {
            if n % i == 0 {
                return false
            }
        }

        return true
    }

    public func run() -> Int {
        b = 93
        c = b

        b *= 100
        b += 100000
        c = b
        c += 17000

        repeat {
            if !isPrime(b) {
                h += 1
            }

            b += 17
        } while b <= c

        return h
    }
}
