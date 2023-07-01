//
//  Node.swift
//  Advent7
//
//  Created by Dragan Cecavac on 07.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Node {
    var children: [Node] = []
    var name: String
    var value: Int
    var total = 0

    init(name: String, value: Int) {
        self.name = name
        self.value = value
    }

    public func add(child new: Node) {
        children.append(new)
    }
}
