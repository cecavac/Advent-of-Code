//
//  Agriculture.swift
//  day-05
//
//  Created by Dragan Cecavac on 05.12.23.
//

import Foundation

class Agriculture {
    private var seeds = [Int]()
    private var mappers = [Mapper]()

    init(_ input: String) {
        let blocks = input.split(separator: "\n\n")

        let seedSection = blocks[0]
        var seedData = seedSection.split(separator: " ")
        seedData.removeFirst()
        for data in seedData {
            seeds.append(Int(String(data))!)
        }

        for i in 1..<blocks.count {
            mappers.append(Mapper(String(blocks[i])))
        }
    }

    private func findLocation(seed: Int) -> Int {
        var result = seed
        for mapper in mappers {
            result = mapper.sourceToDestination(result)
        }
        return result
    }

    private func findSeed(location: Int) -> Int {
        var result = location
        for mapper in mappers.reversed() {
            result = mapper.destinationToSource(result)
        }
        return result
    }

    private func isSeedValid(seed: Int) -> Bool {
        for i in stride(from: 0, to: seeds.count, by: 2) {
            if seed >= seeds[i] && seed < seeds[i] + seeds[i + 1] {
                return true
            }
        }

        return false
    }

    private func findBestAmong(locations: any Sequence<Int>) -> Int  {
        var result = Int.max

        for location in locations {
            let seed = findSeed(location: location)
            if isSeedValid(seed: seed) {
                result = min(result, location)
            }
        }

        return result
    }

    func lowestLocation() -> Int {
        var result = Int.max

        for seed in seeds {
            let location = findLocation(seed: seed)
            result = min(result, location)
        }

        return result
    }

    func actuallyLowestLocation() -> Int {
        // Check location start and end destinations
        let edgeLocations = mappers.last!.collectEdgeDestinations()
        let bestEdgeResult = findBestAmong(locations: edgeLocations)

        // Identify range which contains the best edge values
        var bestEdgeLow = Int.max
        var bestEdgeHigh = Int.max
        for i in stride(from: 0, to: edgeLocations.count, by: 2) {
            if bestEdgeResult == edgeLocations[i] || bestEdgeResult == edgeLocations[i + 1] {
                bestEdgeLow = edgeLocations[i]
                bestEdgeHigh = edgeLocations[i + 1]
            }
        }

        let skipElements = 10000
        // Check every 10k-th element in the selected subsection
        let reducedSequence = stride(from: bestEdgeLow, through: bestEdgeHigh, by: skipElements).reversed()
        let best10kElement = findBestAmong(locations: reducedSequence)

        // Check every element in +/- 10k range of the previous best
        let finalSequence = stride(from: best10kElement - skipElements, through: best10kElement + skipElements, by: 1).reversed()
        return findBestAmong(locations: finalSequence)
    }
}
