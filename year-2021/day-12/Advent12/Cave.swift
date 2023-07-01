//
//  Cave.swift
//  Advent12
//
//  Created by Dragan Cecavac on 12.12.21.
//

import Foundation

class Cave: Equatable, Hashable {
    let isSmall: Bool
    let name: String
    var connections = Set<Cave>()

    init(_ name: String) {
        self.name = name

        let nameArray = Array(name)
        isSmall = nameArray[0].isLowercase
    }

    func connect(to connection: Cave) {
        connections.insert(connection)
        connection.connections.insert(self)
    }

    static func ==(lhs: Cave, rhs: Cave) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
