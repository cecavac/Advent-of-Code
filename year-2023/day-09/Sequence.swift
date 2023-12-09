//
//  Sequence.swift
//  day-09
//
//  Created by Dragan Cecavac on 09.12.23.
//

import Foundation

class Sequence {
    var history = [[Int]]()

    init(history: [Int]) {
        self.history.append(history)
    }

    func expand() {
        while true {
            var newLine = [Int]()
            let depth = history.count - 1

            for i in 0..<(history.last!.count - 1) {
                newLine.append(history[depth][i + 1] - history[depth][i])
            }

            history.append(newLine)
            if newLine.allSatisfy({ $0 == 0 }) {
                break
            }
        }
    }

    func predict() {
        history[history.count - 1].insert(0, at: 0)
        history[history.count - 1].append(0)
        for i in (0..<(history.count - 1)).reversed() {
            let previousValue = history[i].first! - history[i + 1].first!
            history[i].insert(previousValue, at: 0)

            let nextValue = history[i].last! + history[i + 1].last!
            history[i].append(nextValue)
        }
    }

    func nextValue() -> Int {
        return history.first!.last!
    }

    func previousValue() -> Int {
        return history.first!.first!
    }
}
