//
//  Rule.swift
//  day-19
//
//  Created by Dragan Cecavac on 19.12.23.
//

import Foundation

struct Rule {

    let lt: Bool
    let gt: Bool
    let first: String?
    let value: Int?
    let last: String


    init(_ input: String) {
        if Array(input).firstIndex(of: ":") == nil {
            last = input

            lt = false
            gt = false
            first = nil
            value = nil
        } else {
            let elements = input.split(separator: ":")
            let e0 = Array(String(elements[0]))
            first = String(e0.first!)
            last = String(elements[1])

            lt = e0[1] == "<"
            gt = e0[1] == ">"

            value = Int(String(e0[2..<e0.count]))!
        }
    }

    func check(item: Item) -> String? {
        if first == nil {
            return last
        }

        var operand: Int? = nil
        if first! == "x" {
            operand = item.x
        }
        if first! == "m" {
            operand = item.m
        }
        if first! == "a" {
            operand = item.a
        }
        if first! == "s" {
            operand = item.s
        }

        if gt {
            if operand! > value! {
                return last
            }
        }

        if lt {
            if operand! < value! {
                return last
            }
        }


        return nil
    }
}
