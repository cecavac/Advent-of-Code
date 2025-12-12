//
//  Present.swift
//  day-12
//
//  Created by Dragan Cecavac on 12.12.25.
//

struct Present {
    let size: Int
    let orientations: Array<Array<Array<Character>>>

    init (_ input: String) {
        let lines = input.split(separator: "\n")

        var orientation1: Array<Array<Character>> = []
        var size = 0
        for line in lines {
            let array = Array(String(line))
            orientation1.append(array)
            size += String(line).filter { $0 == "#" }.count
        }
        self.size = size

        var orientation2: Array<Array<Character>> = []
        for row in orientation1 {
            orientation2.append(row.reversed())
        }

        var orientation3: Array<Array<Character>> = Array()
        for j in orientation1[0].indices {
            var row = [Character]()
            for i in orientation1.indices {
                row.append(orientation1[i][j])
            }
            orientation3.append(row)
        }

        var orientation4: Array<Array<Character>> = []
        for row in orientation3 {
            orientation4.append(row.reversed())
        }

        orientations = [ orientation1, orientation2, orientation3, orientation4]
    }
}
