//
//  Sneaker.swift
//  Advent13
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Sneaker {
    public static func findDelay(_ input: String) -> Int {
        let firewall = Firewall(input)

        for i in 0..<Int.max {
            if firewall.isSafe(tick: i) {
                return i
            }
        }

        return -1
    }
}
