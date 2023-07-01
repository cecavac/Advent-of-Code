//
//  IPRange.swift
//  Advent20
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct IPRange {
    public static let EndLimit = 4294967295

    var start: Int
    var end: Int

    func intersects(ipRange: IPRange) -> Bool {
        return  (start <= ipRange.start && ipRange.start <= end) ||
            (start <= ipRange.end && ipRange.end <= end) ||
            (end + 1 == ipRange.start) || (ipRange.end + 1 == start)
    }

    func combine(ipRange: IPRange) -> IPRange {
        let combinedStart = min(start, ipRange.start)
        let combinedEnd = max(end, ipRange.end)

        return IPRange(start: combinedStart, end: combinedEnd)
    }

    var hash: String {
        return "\(start)-\(end)"
    }
}
