//
//  Directory.swift
//  Advent07
//
//  Created by Dragan Cecavac on 07.12.22.
//

import Foundation

class Directory: Item {
    var items = [Item]()

    override init(name: String) {
        super.init(name: name)
    }

    override func size() -> Int {
        return items.map { $0.size() }.reduce(0, +)
    }

    func add(_ item: Item) {
        if !contains(item) {
            items.append(item)
        }
    }

    func contains(_ item: Item) -> Bool {
        return items.filter { $0.name == item.name }.count > 0
    }
}
