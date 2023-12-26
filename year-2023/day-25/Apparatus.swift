//
//  Apparatus.swift
//  day-25
//
//  Created by Dragan Cecavac on 25.12.23.
//

import Foundation

class Apparatus {
    var wires = [String:Wire]()
    var hits = [Int:Int]()
    var links = [Link]()
    var allWires = Set<String>()

    init(_ input: String) {
        let adjustedInput = input.replacingOccurrences(of: ":", with: "")
        for line in adjustedInput.split(separator: "\n") {
            let elements = line.split(separator: " ")
            let wireId = String(elements[0])
            wires[wireId] = Wire(id: wireId)
            for i in 1..<elements.count {
                let targetId = String(elements[i])
                let link = Link(wire1: wireId, wire2: targetId)
                links.append(link)

                allWires.insert(wireId)
                allWires.insert(targetId)
            }
        }

        appointLinks()
    }

    func appointLinks() {
        for link in links {
            if wires[link.wire1] == nil {
                wires[link.wire1] = Wire(id: link.wire1)
            }
            if wires[link.wire2] == nil {
                wires[link.wire2] = Wire(id: link.wire2)
            }

            let wire1 = wires[link.wire1]!
            wire1.links.append(link)

            let wire2 = wires[link.wire2]!
            wire2.links.append(link)
        }
    }

    func countConnected(start: String, skip: Set<Int>) -> Set<String> {
        var connected = Set<String>()
        connected.insert(start)

        while true {
            let connectedCount = connected.count

            for wire in wires.keys {
                if connected.contains(wire) {
                    for link in wires[wire]!.links {
                        if !skip.contains(link.id) {
                            connected.insert(link.wire1)
                            connected.insert(link.wire2)
                        }
                    }
                }
            }

            for link in links {
                if !skip.contains(link.id) {
                    if connected.contains(link.wire1) || connected.contains(link.wire2) {
                        connected.insert(link.wire1)
                        connected.insert(link.wire2)
                    }
                }
            }

            if connected.count == connectedCount {
                break
            }
        }

        return connected
    }

    func explore(skip: Set<Int>) -> Int {
        let first = wires.keys.first!
        let connected1 = countConnected(start: first, skip: skip)

        if connected1.count >= allWires.count - 3 {
            return connected1.count
        }

        var second: String? = nil
        for wire in allWires {
            if !connected1.contains(wire) {
                second = wire
                break
            }
        }
        let connected2 = countConnected(start: second!, skip: skip)

        if connected1.count + connected2.count == allWires.count {
            return max(connected1.count, connected2.count)
        } else {
            return 0
        }
    }

    func reach(from: String, target: String) -> Set<Int> {
        var fromPath = Set<String>()
        fromPath.insert(from)
        let fromLinks = Set<Int>()
        let fromExplorer = Explorer(current: from, path: fromPath, links: fromLinks)
        var explorers = [fromExplorer]

        while true {
            for explorer in explorers {
                if explorer.path.contains(target) {
                    return explorer.links
                }
            }

            var newExplorers = [Explorer]()
            for explorer in explorers {
                let wire = wires[explorer.current]!
                for link in wire.links {
                    if explorer.current == link.wire2 {
                        var link1Found = false
                        for ex in explorers {
                            if ex.path.contains(link.wire1) {
                                link1Found = true
                                break
                            }
                        }

                        if !link1Found {
                            var newPath = explorer.path
                            newPath.insert(link.wire1)
                            var newlinks = explorer.links
                            newlinks.insert(link.id)
                            let newExplorer = Explorer(current: link.wire1, path: newPath, links: newlinks)
                            newExplorers.append(newExplorer)
                        }
                    }

                    if explorer.current == link.wire1 {
                        var link2Found = false
                        for ex in explorers {
                            if ex.path.contains(link.wire2) {
                                link2Found = true
                                break
                            }
                        }

                        if !link2Found {
                            var newPath = explorer.path
                            newPath.insert(link.wire2)
                            var newlinks = explorer.links
                            newlinks.insert(link.id)
                            let newExplorer = Explorer(current: link.wire2, path: newPath, links: newlinks)
                            newExplorers.append(newExplorer)
                        }
                    }
                }
            }
            explorers = newExplorers
        }
    }

    func getMostCommonLinks() -> Set<Int> {
        for _ in 0..<250 {
            let from = allWires.randomElement()!
            let to = allWires.randomElement()!
            if from != to {
                let usedLinks = reach(from: from, target: to)
                for linkId in usedLinks {
                    hits[linkId] = (hits[linkId] ?? 0) +  1
                }
            }
        }

        var hitsPerLink = [(Int, Int)]()
        for (key, value) in hits {
            hitsPerLink.append((key, value))
        }
        hitsPerLink.sort { $0.1 >= $1.1 }

        var mostCommonLinks = Set<Int>()
        for i in 0..<3 {
            mostCommonLinks.insert(hitsPerLink[i].0)
        }
        return mostCommonLinks
    }

    func sum() -> Int {
        let ignore = getMostCommonLinks()
        let count = explore(skip: ignore)
        return count * (allWires.count - count)
    }
}
