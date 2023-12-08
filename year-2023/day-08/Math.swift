//
//  Math.swift
//  day-08
//
//  Created by Dragan Cecavac on 08.12.23.
//

import Foundation

class Math {
    public static func gcd(_ a: Int, _ b: Int) -> Int {
        if b == 0 {
            return a
        } else {
            return gcd(b, a % b)
        }
    }

    public static func lcm(_ a: Int, _ b: Int) -> Int {
        return a * b / gcd(a, b)
    }
}
