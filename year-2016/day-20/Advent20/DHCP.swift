//
//  dhcp.swift
//  Advent20
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class DHCP {
    var blacklisted: [IPRange] = []

    init(_ inpit: String) {
        let lines = inpit.split(separator: "\n")
        for line in lines {
            let elements = line.split(separator: "-")
            let ipRange = IPRange(start: Int(elements[0])!, end: Int(elements[1])!)
            blacklisted.append(ipRange)
        }

        blacklisted.sort { $0.start < $1.start }
        aggregate()
    }

    private func aggregate() {
        var changed: Bool

        repeat {
            changed = false

            var expelled = Set<String>()
            var newBlacklisted: [IPRange] = []

            for i in 0..<blacklisted.count {
                for j in i + 1..<blacklisted.count {
                    if blacklisted[i].intersects(ipRange: blacklisted[j]) {
                        let newElement = blacklisted[i].combine(ipRange: blacklisted[j])
                        newBlacklisted.append(newElement)

                        expelled.insert(blacklisted[i].hash)
                        expelled.insert(blacklisted[j].hash)

                        changed = true
                        break
                    }
                }

                if changed {
                    break
                }
            }

            for element in blacklisted {
                if !expelled.contains(element.hash) {
                    newBlacklisted.append(element)
                }
            }

            blacklisted = newBlacklisted
        } while changed
    }

    var firstNonblacklisted: Int {
        var firstNonblacklisted = Int.max

        for element in blacklisted {
            firstNonblacklisted = min(firstNonblacklisted, element.end)
        }

        return firstNonblacklisted + 1
    }

    var allowed: Int {
        var allowed = IPRange.EndLimit + 1
        var cnt = 0

        blacklisted.sort { $0.start < $1.start }

        for element in blacklisted {
            let range = element.end - element.start + 1
            allowed -= range
            cnt += range
        }

        return allowed
    }
}
