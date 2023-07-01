//
//  Spinlock.swift
//  Advent17
//
//  Created by Dragan Cecavac on 12.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Spinlock {
    var queue: [Int] = []
    let offset: Int
    var position = 0

    init(offset: Int, cycles: Int) {
        self.offset = offset

        queue.append(0)
        for i in 1...cycles {
            insert(element: i)
        }
    }

    private func insert(element: Int) {
        position = (position + offset) % queue.count
        position += 1
        queue.insert(element, at: position)
    }

    public func getElement(after: Int) -> Int {
        var index = -1

        for i in 0..<queue.count {
            if queue[i] == after {
                index = i
                break
            }
        }

        if index == -1 {
            return index
        } else {
            index = (index + 1) % queue.count
            return queue[index]
        }
    }
}
