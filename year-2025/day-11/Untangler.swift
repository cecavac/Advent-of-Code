//
//  Untangler.swift
//  day-11
//
//  Created by Dragan Cecavac on 11.12.25.
//

class Untangler {
    let nodes: Array<Node>
    var nodeMap = [String: Node]()
    var visitScore = [String: Int]()
    var visited = Set<String>()

    init(_ data: String) {
        nodes = data.split(separator: "\n")
            .map { Node(String($0)) }

        for node in nodes {
            nodeMap[node.from] = node
        }
    }

    func youOut() -> Int {
        return explore(start: "you", target: "out", skip: [])
    }

    func explore(start: String, target: String, skip: Array<String>) -> Int {
        visitScore.removeAll()
        visited.removeAll()

        visitScore[start] = 1
        visited.insert(start)

        while true {
            var changedSomething = false
            for node in visited {
                if node == "out" || node == target || skip.contains(node) {
                    continue
                }

                if let value = visitScore[node] {
                    for to in nodeMap[node]!.to {
                        if skip.contains(to) {
                            continue
                        }

                        visitScore[to] = (visitScore[to] ?? 0) + value
                        visited.insert(to)
                        changedSomething = true
                    }

                    visitScore.removeValue(forKey: node)
                }
            }

            if !changedSomething {
                return visitScore[target] ?? 0
            }
        }
    }

    func svrOut() -> Int {
        let start = "svr"
        let mid1 = "dac"
        let mid2 = "fft"
        let target = "out"

        let srvDac = explore(start: start, target: mid1, skip: [mid2, target])
        let srvFft = explore(start: start, target: mid2, skip: [mid1, target])

        let dacFft = explore(start: mid1, target: mid2, skip: [start, target])
        let fftDac = explore(start: mid2, target: mid1, skip: [start, target])

        let dacOut = explore(start: mid1, target: target, skip: [start, mid2])
        let fftOut = explore(start: mid2, target: target, skip: [start, mid1])

        let dacFftRoutes = srvDac * dacFft * fftOut
        let fftDacRoutes = srvFft * fftDac * dacOut

        return dacFftRoutes + fftDacRoutes
    }
}
