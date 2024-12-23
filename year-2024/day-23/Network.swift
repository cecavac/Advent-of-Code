//
//  Network.swift
//  day-23
//
//  Created by Dragan Cecavac on 23.12.24.
//

class Network {
    var bestLan = Set<String>()
    var cache = Set<String>()

    var lan = [String:Set<String>]()

    init(_ data: String) {
        let lines = data.split(separator: "\n")
        for line in lines {
            let nodes = line.split(separator: "-")
            let node0 = String(nodes[0])
            let node1 = String(nodes[1])
            if lan[node0] == nil {
                lan[node0] = Set<String>()
            }
            if lan[node1] == nil {
                lan[node1] = Set<String>()
            }
            lan[node0]!.insert(node1)
            lan[node1]!.insert(node0)
        }
    }

    func triple() -> Int {
        var result = 0

        for node0 in lan.keys {
            for node1 in lan[node0]! {
                for node2 in lan[node1]! {
                    if lan[node2]!.contains(node0) {
                        if node0.starts(with: "t") || node1.starts(with: "t") || node2.starts(with: "t") {
                            result += 1
                        }
                    }
                }
            }
        }

        // Permutations of 3!
        return result / 6
    }

    func explore(root:String, at: String, visited: Set<String>) {
        let hash = visited.sorted().joined(separator: ",")
        if cache.contains(hash) {
            return
        } else {
            cache.insert(hash)
        }

        for element in lan[at]! {
            if element == root {
                if visited.count > bestLan.count {
                    bestLan = visited
                }
            }

            if visited.contains(element) {
                continue
            }

            var notConnectedToAPreviousNode = false
            for previous in visited {
                if !lan[element]!.contains(previous) {
                    notConnectedToAPreviousNode = true
                    break
                }
            }
            if notConnectedToAPreviousNode {
                continue
            }

            var newVisited = visited
            newVisited.insert(element)
            explore(root: root, at: element, visited: newVisited)
        }
    }

    func password() -> String {
        for node in lan.keys {
            if !bestLan.contains(node) {
                var visited = Set<String>()
                visited.insert(node)
                explore(root: node, at: node, visited: visited)
            }
        }

        return bestLan.sorted().joined(separator: ",")
    }
}
