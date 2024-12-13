//
//  Claw.swift
//  day-13
//
//  Created by Dragan Cecavac on 13.12.24.
//

class Claw {
    let ax: Int
    let ay: Int
    let bx: Int
    let by: Int
    let px: Int
    let py: Int

    init(_ data: String) {
        let adjustedString = data
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "+", with: " ")
            .replacingOccurrences(of: "=", with: " ")

        let elements = adjustedString.split(separator: " ")
        ax = Int(String(elements[3]))!
        ay = Int(String(elements[5]))!
        bx = Int(String(elements[9]))!
        by = Int(String(elements[11]))!
        px = Int(String(elements[14]))!
        py = Int(String(elements[16]))!
    }

    func solve(boosted: Bool) -> (Int, Int) {
        var npx = px
        var npy = py
        if boosted {
            npx += 10000000000000
            npy += 10000000000000
        }

        let j = Double(npx * ay - npy * ax) / Double(bx * ay - by * ax)
        let i = (Double(npx) - j * Double(bx)) / Double(ax)

        if i != Double(Int(i)) || j != Double(Int(j)) {
            return (-1, -1)
        }

        return (Int(i), Int(j))
    }

    func score(boosted: Bool) -> Int {
        let (i, j) = solve(boosted: boosted)
        if i != -1 && j != -1 {
            return i * 3 + j
        }

        return 0
    }
}
