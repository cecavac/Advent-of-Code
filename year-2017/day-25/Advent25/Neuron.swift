//
//  Neuron.swift
//  Advent25
//
//  Created by Dragan Cecavac on 18.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Neuron {
    let valueWhen0: Int
    let valueWhen1: Int
    let goRightWhen0: Bool
    let goRightWhen1: Bool
    let stateWhen0: String
    let stateWhen1: String

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        var rows: [[Character]] = []
        for line in lines {
            let row = Array<Character>(String(line))
            rows.append(row)
        }

        valueWhen0 = Int(String(rows[1].last!))!
        let row2 = lines[2].split(separator: " ")
        goRightWhen0 = String(row2[5]) == "right"
        stateWhen0 = String(rows[3].last!)

        valueWhen1 = Int(String(rows[5].last!))!
        let row6 = lines[6].split(separator: " ")
        goRightWhen1 = String(row6[5]) == "right"
        stateWhen1 = String(rows[7].last!)
    }
}
