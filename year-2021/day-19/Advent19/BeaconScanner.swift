//
//  BeaconScanner.swift
//  Advent19
//
//  Created by Dragan Cecavac on 19.12.21.
//

import Foundation

class BeaconScanner {
    var scanners = [Scanner]()
    var beacons = Set<String>()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            if line.contains(" ") {
                scanners.append(Scanner())
            } else {
                let scanner = scanners.last!
                scanner.addBeacon(String(line))
            }
        }
        scanners[0].setPosition(i: 0, j: 0, z: 0)
        for scanner in scanners {
            scanner.generateFingerprints()
        }
    }

    var globalBeacon = 0
    func nextBeacon() {
        globalBeacon += 1
        globalBeacon %= scanners[0].beacons.count
    }

    func attemptToGroup(s1: Scanner, s2: Scanner) -> Bool {
        let originalS1SelectedBaseBeacon = s1.selectedBaseBeacon

        let temporaryS1SelectedBaseBeacon = globalBeacon
            s1.selectedBaseBeacon = temporaryS1SelectedBaseBeacon

        if let intersection = s2.getIntersection(against: s1) {
            let firstBeaconDistance = intersection.first!

            let baseOriginalCoordinates = s1.originalCoordinatesArray[s1.selectedBaseBeacon!][s1.fingerprintVariation!]
            let baseOriginalCoordinatesParsed = baseOriginalCoordinates[firstBeaconDistance]!.split(separator: "#")
            let beaconI = s1.positionI! + Int(String(baseOriginalCoordinatesParsed[0]))!
            let beaconJ = s1.positionJ! + Int(String(baseOriginalCoordinatesParsed[1]))!
            let beaconZ = s1.positionZ! + Int(String(baseOriginalCoordinatesParsed[2]))!

            let currentOriginalCoordinates = s2.originalCoordinatesArray[s2.selectedBaseBeacon!][s2.fingerprintVariation!]
            let currentOriginalCoordinatesParsed = currentOriginalCoordinates[firstBeaconDistance]!.split(separator: "#")
            s2.positionI = beaconI - Int(String(currentOriginalCoordinatesParsed[0]))!
            s2.positionJ = beaconJ - Int(String(currentOriginalCoordinatesParsed[1]))!
            s2.positionZ = beaconZ - Int(String(currentOriginalCoordinatesParsed[2]))!

            s1.selectedBaseBeacon = originalS1SelectedBaseBeacon
            return true
        }

        s1.selectedBaseBeacon = originalS1SelectedBaseBeacon
        return false
    }

    func groupFrist2Pairs() {
        let baseScanner = scanners[0]
        for i in 1..<scanners.count {
            for baseSelectedBeacon in baseScanner.fingerprintsArray.indices {
                for baseVariation in 0..<Scanner.combinations {
                    let currentScanner = scanners[i]

                    baseScanner.fingerprintVariation = baseVariation
                    baseScanner.selectedBaseBeacon = baseSelectedBeacon

                    if attemptToGroup(s1: baseScanner, s2: currentScanner) {
                        return
                    }
                }
            }
        }
    }

    func groupScanners() {
        while (scanners.filter { $0.fingerprintVariation != nil }).count < scanners.count {
            for groupedScanner in scanners.filter({ $0.fingerprintVariation != nil }) {
                for ungroupedScanner in scanners.filter({ $0.fingerprintVariation == nil }) {
                    _ = attemptToGroup(s1: groupedScanner, s2: ungroupedScanner)
                }
            }

            nextBeacon()
        }

    }

    func collectBeacons() {
        for scanner in scanners {
            for beacon in scanner.getBeacons() {
                beacons.insert(beacon)
            }
        }
    }

    func maxDistance()  -> Int {
        var maxDistance = 0

        for scanner1 in scanners {
            for scanner2 in scanners {
                let distance = abs(scanner1.positionI! - scanner2.positionI!) + abs(scanner1.positionJ! - scanner2.positionJ!) + abs(scanner1.positionZ! - scanner2.positionZ!)
                maxDistance = max(maxDistance, distance)
            }
        }

        return maxDistance
    }
}
