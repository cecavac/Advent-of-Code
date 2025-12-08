//
//  Circuit.swift
//  day-08
//
//  Created by Dragan Cecavac on 08.12.25.
//

class Circuit {
    let boxes: Array<JunctionBox>
    var circuitMap = [Int: Array<JunctionBox>]()
    var pairDistances = [PairDistance]()
    var lastPair: PairDistance? = nil

    init(_ data: String) {
        boxes = data.split(separator: "\n")
            .map { JunctionBox(String($0)) }
        for box in boxes {
            circuitMap[box.circuitId] = [box]
        }
        fillDistances()
    }

    func fillDistances() {
        for i in 0..<(boxes.count - 1) {
            for j in (i + 1)..<boxes.count {
                let distance = boxes[i].distance(box: boxes[j])
                pairDistances.append(PairDistance(box1: boxes[i], box2: boxes[j], distance: distance))
            }
        }
        pairDistances = pairDistances.sorted { $0.distance > $1.distance }
    }

    func organize(count: Int) {
        for _ in 0..<count {
            let newPair = pairDistances.removeLast()
            let id1 = newPair.box1.circuitId
            let id2 = newPair.box2.circuitId

            if id1 != id2 {
                for box in circuitMap[id2]! {
                    circuitMap[id1]!.append(box)
                    box.circuitId = id1
                }
                circuitMap.removeValue(forKey: id2)
                lastPair = newPair
            }
        }
    }

    func group(count: Int) -> Int {
        organize(count: count)
        let circuitCount = circuitMap.values
            .map { $0.count }
            .sorted { $0 > $1 }
        return circuitCount[0] * circuitCount[1] * circuitCount[2]
    }

    func findLast() -> Int {
        while pairDistances.count != 0 {
            organize(count: 1)
        }

        return lastPair!.box1.x * lastPair!.box2.x
    }
}
