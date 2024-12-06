//
//  Obstructor.swift
//  day-06
//
//  Created by Dragan Cecavac on 06.12.24.
//

class Obstructor {
    static func possibilities(_ input: String) -> Int {
        var result = 0
        let referenceTracker = Tracker(input)
        referenceTracker.walk()

        for i in referenceTracker.map.indices {
            for j in referenceTracker.map[0].indices {
                if let visited = referenceTracker.visited["\(i)#\(j)"] {
                    if visited && referenceTracker.map[i][j] == "." {
                        let tracker = Tracker(input)

                        // Placing the guard in front of the new obstacle
                        // would optimize execution
                        tracker.map[i][j] = "#"
                        tracker.walk()

                        if tracker.stuckInALoop {
                            result += 1
                        }
                    }
                }
            }
        }

        return result
    }
}
