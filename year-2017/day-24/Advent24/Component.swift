//
//  Component.swift
//  Advent24
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct Component : Hashable {
    let originalEndA: Int
    let originalEndB: Int

    var endA: Int
    var endB: Int

    init(_ input: String) {
        let elements = input.split(separator: "/")
        originalEndA = Int(elements[0])!
        endA = originalEndA
        originalEndB = Int(elements[1])!
        endB = originalEndB
    }

    mutating public func rotate() {
        let t = endA
        endA = endB
        endB = t
    }

    public func hash() -> String {
        return "\(originalEndA)#\(originalEndB)|"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(hash())
    }

    static func == (lhs: Component, rhs: Component) -> Bool {
        return  lhs.originalEndA == rhs.originalEndA &&
                lhs.originalEndB == rhs.originalEndB
    }
}
