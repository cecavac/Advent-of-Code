//
//  Pipeline.swift
//  Advent16
//
//  Created by Dragan Cecavac on 16.12.22.
//

import Foundation

class Pipeline {
    var map = [String:Valve]()
    var cache = [String:Int]()
    var distinctOpenIds = [Int:Set<String>]()
    var distinctOpenIdResults = [Int:Int]()

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            let parsedLine = Valve.parse(String(line))
            let id = parsedLine[1]
            let flow = Int(parsedLine[5])!
            let valve = Valve(id: id, flow: flow)
            map[id] = valve
        }

        for line in input.split(separator: "\n") {
            let parsedLine = Valve.parse(String(line))
            let id = parsedLine[1]
            let valve = map[id]!
            for i in 10..<parsedLine.count {
                let upstreamId = parsedLine[i]
                let upstreamValve = map[upstreamId]!
                valve.addUpstream(valve: upstreamValve)
            }
            map[id] = valve
        }
    }

    private func getFlow(openedIds: Set<String>) -> Int {
        return openedIds.map { map[$0]!.flow }.reduce(0, +)
    }

    private func explore(openedIds: Set<String>, minute: Int, valve: Valve, skip: Valve) -> Int {
        let openIdsHash = openedIds.hashValue
        let currentFlow = getFlow(openedIds: openedIds)

        if minute == 30 {
            return currentFlow
        }

        let cacheTimestamp = "\(openIdsHash)#\(minute)#\(valve.id)"
        if let cachedSubResult = cache[cacheTimestamp] {
            return cachedSubResult + currentFlow
        }

        var bestSubresult = 0
        if !openedIds.contains(valve.id) && valve.flow > 0 {
            var ids = openedIds
            ids.insert(valve.id)

            if minute < 29 {
                for upstream in valve.upstream {
                    let subresult = explore(openedIds: ids, minute: minute + 2, valve: upstream, skip: valve) + currentFlow
                    bestSubresult =  max(bestSubresult, subresult)
                }
            }
        }

        for upstream in valve.upstream {
            if upstream.id != skip.id {
                let subresult = explore(openedIds: openedIds, minute: minute + 1, valve: upstream, skip: valve)
                bestSubresult = max(bestSubresult, subresult)
            }
        }

        cache[cacheTimestamp] = bestSubresult
        let result =  bestSubresult + currentFlow

        return result
    }

    private func pairExplore(openedIds: Set<String>, minute: Int, valve: Valve,
                         skip: Valve, released: Int) -> Int {
        let openIdsHash = openedIds.hashValue
        let currentFlow = getFlow(openedIds: openedIds)

        if minute == 30 {
            if let distinctOpenIdResult = distinctOpenIdResults[openIdsHash] {
                if distinctOpenIdResult < released + currentFlow {
                    distinctOpenIds[openIdsHash] = openedIds
                    distinctOpenIdResults[openIdsHash] = released + currentFlow
                }
            } else {
                distinctOpenIds[openIdsHash] = openedIds
                distinctOpenIdResults[openIdsHash] = released + currentFlow
            }

            return released + currentFlow
        }

        let cacheTimestamp = "\(openIdsHash)#\(minute)#\(valve.id)#\(released)"
        if let cachedSubResult = cache[cacheTimestamp] {
            return cachedSubResult
        }

        var bestSubresult = 0
        if !openedIds.contains(valve.id) && valve.flow > 0 {
            var ids = openedIds
            ids.insert(valve.id)

            if minute < 29 {
                for upstream in valve.upstream {
                    let subresult = pairExplore(openedIds: ids, minute: minute + 2, valve: upstream,
                                            skip: valve, released: released + currentFlow * 2)
                    bestSubresult =  max(bestSubresult, subresult)
                }
            }
        }

        for upstream in valve.upstream {
            if upstream.id != skip.id {
                let subresult = pairExplore(openedIds: openedIds, minute: minute + 1, valve: upstream,
                                        skip: valve, released: released + currentFlow)
                bestSubresult = max(bestSubresult, subresult)
            }
        }

        cache[cacheTimestamp] = bestSubresult
        let result =  bestSubresult

        return result
    }

    func explore() -> Int {
        return explore(openedIds: Set<String>(), minute: 0, valve: map["AA"]!, skip: map["AA"]!)
    }

    func pairExplore() -> Int {
        // collect all cache data
        _ = pairExplore(openedIds: Set<String>(), minute: 4, valve: map["AA"]!, skip: map["AA"]!, released: 0)

        var result = 0
        for (key1, value1) in distinctOpenIds {
            for (key2, value2) in distinctOpenIds {
                if value1.intersection(value2).count == 0 {
                    result = max(result, distinctOpenIdResults[key1]! + distinctOpenIdResults[key2]!)
                }
            }
        }

        return result
    }
}
