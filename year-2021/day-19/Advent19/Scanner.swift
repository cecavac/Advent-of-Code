//
//  Scanner.swift
//  Advent19
//
//  Created by Dragan Cecavac on 19.12.21.
//

import Foundation

class Scanner {
    var beacons = [(Int, Int, Int)]()

    var positionI: Int? = nil
    var positionJ: Int? = nil
    var positionZ: Int? = nil

    func setPosition(i: Int, j: Int, z: Int) {
        positionI = i
        positionJ = j
        positionZ = z
    }

    func addBeacon(_ input: String) {
        let elements = input.split(separator: ",")
        let beaconI = Int(String(elements[0]))!
        let beaconJ = Int(String(elements[1]))!
        let beaconZ = Int(String(elements[2]))!
        beacons.append((beaconI, beaconJ, beaconZ))
    }

    var selectedBaseBeacon: Int? = nil
    var fingerprintsArray = [Array<Set<String>>]()
    var originalCoordinatesArray = [Array<Dictionary<String,String>>]()

    func rotateVectorZ(_ vector: [Int]) -> [Int] {
        return [-vector[1], vector[0], vector[2]]
    }

    func rotateVectorY(_ vector: [Int]) -> [Int] {
        return [vector[2], vector[1], -vector[0]]
    }

    func rotateVectorX(_ vector: [Int]) -> [Int] {
        return [vector[0], vector[2], -vector[1]]
    }

    func hash(_ vector: [Int]) -> String {
        return "\(vector[0])#\(vector[1])#\(vector[2])"
    }

    func generateFingerprintSection(distances: [Int], coordinates: [Int], index: inout Int, fingerprints: inout [Set<String>], originalCoordinates: inout [[String:String]]) {
        var hash1: String
        var rotatedDistances = distances
        var rotatedCoordinates = coordinates

        for _ in 0..<4 {
            rotatedDistances = rotateVectorZ(rotatedDistances)
            hash1 = hash(rotatedDistances)
            fingerprints[index].insert(hash1)
            rotatedCoordinates = rotateVectorZ(rotatedCoordinates)
            originalCoordinates[index][hash1] = (hash(rotatedCoordinates))
            index += 1
        }
    }

    static let combinations = 24

    func generateFingerprints() {
        for baseBeacon in beacons {
            var fingerprints = Array<Set<String>>(repeating: Set<String>(), count: Scanner.combinations)
            var originalCoordinates = Array<Dictionary<String,String>>(repeating: Dictionary<String,String>(), count: Scanner.combinations)

            for beacon in beacons {
                let distanceI = beacon.0 - baseBeacon.0
                let distanceJ = beacon.1 - baseBeacon.1
                let distanceZ = beacon.2 - baseBeacon.2

                var index = 0
                var distances = [distanceI, distanceJ, distanceZ]
                var coordinates = [beacon.0, beacon.1, beacon.2]

                for _ in 0..<4 {
                    distances = rotateVectorY(distances)
                    coordinates = rotateVectorY(coordinates)
                    generateFingerprintSection(distances: distances, coordinates: coordinates, index: &index, fingerprints: &fingerprints, originalCoordinates: &originalCoordinates)
                }

                distances = rotateVectorX(distances)
                coordinates = rotateVectorX(coordinates)
                generateFingerprintSection(distances: distances, coordinates: coordinates, index: &index, fingerprints: &fingerprints, originalCoordinates: &originalCoordinates)

                distances = rotateVectorX(distances)
                distances = rotateVectorX(distances)
                coordinates = rotateVectorX(coordinates)
                coordinates = rotateVectorX(coordinates)
                generateFingerprintSection(distances: distances, coordinates: coordinates, index: &index, fingerprints: &fingerprints, originalCoordinates: &originalCoordinates)
            }

            fingerprintsArray.append(fingerprints)
            originalCoordinatesArray.append(originalCoordinates)
        }
    }

    var fingerprintVariation: Int? = nil

    func getIntersection(against baseScanner: Scanner) -> Set<String>? {
        let baseFingerprint = baseScanner.fingerprintsArray[baseScanner.selectedBaseBeacon!][baseScanner.fingerprintVariation!]
        for i in fingerprintsArray.indices {
            for j in fingerprintsArray[i].indices {
                let intersection = baseFingerprint.intersection(fingerprintsArray[i][j])
                if intersection.count >= 12 {
                    selectedBaseBeacon = i
                    fingerprintVariation = j
                    return intersection
                }
            }
        }

        return nil
    }

    func getBeacons() -> Set<String> {
        var result = Set<String>()

        for (_, coordinates) in originalCoordinatesArray[selectedBaseBeacon!][fingerprintVariation!] {
            let parsedCoordinates = coordinates.split(separator: "#")
            let position = [ positionI! + Int(String(parsedCoordinates[0]))!,
                             positionJ! + Int(String(parsedCoordinates[1]))!,
                             positionZ! + Int(String(parsedCoordinates[2]))!]
            result.insert(hash(position))
        }

        return result
    }
}
