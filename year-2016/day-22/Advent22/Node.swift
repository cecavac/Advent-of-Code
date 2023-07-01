//
//  Node.swift
//  Advent22
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct Node {
    let x: Int
    let y: Int

    var size: Int
    var used: Int
    var available: Int
    var use: Int

    init(_ input: String) {
        let elements = input.split(separator: " ")
        let nameElements = elements[0].split(separator: "-")

        let xElement = nameElements[1].suffix(nameElements[1].count - 1)
        x = Int(xElement)!

        let yElement = nameElements[2].suffix(nameElements[2].count - 1)
        y = Int(yElement)!

        let sizeElement = elements[1].prefix(elements[1].count - 1)
        size = Int(sizeElement)!

        let usedElement = elements[2].prefix(elements[2].count - 1)
        used = Int(usedElement)!

        let availableElement = elements[3].prefix(elements[3].count - 1)
        available = Int(availableElement)!

        let useElement = elements[4].prefix(elements[4].count - 1)
        use = Int(useElement)!
    }
}
