//
//  Node.swift
//  day-23
//
//  Created by Dragan Cecavac on 23.12.23.
//

import Foundation

class Node: Hashable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.i == rhs.i && lhs.j == rhs.j
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(i)
        hasher.combine(j)
    }

    var distance = 1
    var links = Set<Node>()
    var id: String
    let i: Int
    let j: Int

    init(id: String) {
        self.id = id

        let elements = id.split(separator: "#")
        i = Int(String(elements[0]))!
        j = Int(String(elements[1]))!
    }
}

