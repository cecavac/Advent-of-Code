//
//  File.swift
//  Advent07
//
//  Created by Dragan Cecavac on 07.12.22.
//

import Foundation

class File: Item {
    let fileSize: Int

    init(name: String, size: Int) {
        fileSize = size
        super.init(name: name)
    }

    override func size() -> Int {
        return fileSize
    }
}
