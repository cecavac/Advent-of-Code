//
//  Item.swift
//  day-19
//
//  Created by Dragan Cecavac on 19.12.23.
//

import Foundation

struct Item {
    let x: Int
    let m: Int
    let a: Int
    let s: Int

    init(_ input: String) {
        let adapted = input.replacingOccurrences(of: "{", with: "")
            .replacingOccurrences(of: "}", with: "")
            .replacingOccurrences(of: "=", with: " ")
            .replacingOccurrences(of: ",", with: " ")
        let elements = adapted.split(separator: " ")

        if elements[0] != "x" || elements[2] != "m" || elements[4] != "a" || elements[6] != "s" {
            print("error")
        }
        x = Int(String(elements[1]))!
        m = Int(String(elements[3]))!
        a = Int(String(elements[5]))!
        s = Int(String(elements[7]))!
    }

    func sum() -> Int {
        return x + m + a + s
    }
}
