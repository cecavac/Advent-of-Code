//
//  FakeSpinlock.swift
//  Advent17
//
//  Created by Dragan Cecavac on 12.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class FakeSpinlock {
    let offset: Int
    var queueSize = 1
    var position = 0
    var result = -1

    init(offset: Int, cycles: Int) {
        self.offset = offset

        for i in 1...cycles {
            position = (position + offset) % queueSize
            position += 1
            queueSize += 1

            if position == 1 {
                result = i
            }
        }
    }
}
