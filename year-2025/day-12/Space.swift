//
//  Space.swift
//  day-12
//
//  Created by Dragan Cecavac on 12.12.25.
//

class Space {
    let width: Int
    let height: Int
    let size: Int
    let requirements: Array<Int>
    let presents: Array<Present>

    init(_ data: String, presents: Array<Present>) {
        let elements = data.split(separator: ": ")
        let sizes = elements[0].split(separator: "x")

        width = Int(String(sizes[0]))!
        height = Int(String(sizes[1]))!
        size = width * height

        requirements = elements[1].split(separator: " ")
            .map { Int(String($0))! }

        self.presents = presents
    }

    func canFit() -> Bool {
        var requiredSize = 0
        for i in requirements.indices {
            requiredSize += requirements[i] * presents[i].size
        }

        if requiredSize > size {
            // Don't even attempt to fit
            return false
        }

        let area: Array<Array<Character>> = Array(
            repeating: Array(repeating: ".", count: width),
            count: height
        )
        let filled = Array(repeating: 0, count: requirements.count)
        return explore(area: area, filled: filled)
    }

    func explore(area: Array<Array<Character>>, filled: Array<Int>) -> Bool {
        var candidate = -1
        var newFilled = filled

        for i in requirements.indices {
            if filled[i] < requirements[i] {
                newFilled[i] += 1
                candidate = i
                break
            }
        }
        if candidate == -1 {
            return true
        }

        for positionI in 0..<height {
            for positionJ in 0..<width {
                for orientation in presents[candidate].orientations {
                    var newArea = area
                    let presentHeight = orientation.count
                    let presentWidth = orientation[0].count

                    if positionI + presentHeight >= height
                        || positionJ + presentWidth >= width {
                        continue
                    }

                    var cantFit = false
                    for areaI in positionI..<(positionI + presentHeight) {
                        if cantFit {
                            break
                        }

                        for areaJ in positionJ..<(positionJ + presentWidth) {
                            let presentI = areaI - positionI
                            let presentJ = areaJ - positionJ
                            if orientation[presentI][presentJ] == "#" {
                                if newArea[areaI][areaJ] == "#" {
                                    cantFit = true
                                    break
                                }

                                newArea[areaI][areaJ] = "#"
                            }
                        }
                    }

                    if explore(area: newArea, filled: newFilled) {
                        return true
                    }
                }
            }
        }

        return false
    }
}
