//
//  Packets.swift
//  Advent13
//
//  Created by Dragan Cecavac on 13.12.22.
//

import Foundation

class Packets {
    var pairs = [(Sequence, Sequence)]()

    init(_ input: String) {
        let pairLines = input.split(separator: "\n\n")
        for pairLine in pairLines {
            let pair = pairLine.split(separator: "\n")
            let sequence1 = Sequence(String(pair[0]))
            let sequence2 = Sequence(String(pair[1]))
            pairs.append((sequence1, sequence2))
        }
    }

    func compare() -> Int {
        var result = 0
        for i in pairs.indices {
            if pairs[i].0.compare(with: pairs[i].1) {
                result += i + 1
            }
        }
        return result
    }

    func sort() -> Int {
        var packets = pairs.map { $0.0 }
        packets += pairs.map { $0.1 }

        let divider1 = Sequence("[[2]]")
        let divider2 = Sequence("[[6]]")
        packets.append(divider1)
        packets.append(divider2)

        packets = packets.sorted(by: { $0.compare(with: $1) })

        var result = 1
        for i in packets.indices {
            if packets[i].id == divider1.id || packets[i].id == divider2.id {
                result *= i + 1
            }
        }

        return result
    }
}
