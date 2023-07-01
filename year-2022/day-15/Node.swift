//
//  Node.swift
//  Advent15
//
//  Created by Dragan Cecavac on 15.12.22.
//

import Foundation

struct Node {
    let i: Int
    let j: Int

    func distance(to other: Node) -> Int {
        return abs(i - other.i) + abs(j - other.j)
    }
}
