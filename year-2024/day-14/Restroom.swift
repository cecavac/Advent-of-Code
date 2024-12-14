//
//  Restroom.swift
//  day-14
//
//  Created by Dragan Cecavac on 14.12.24.
//

class Restroom {
    let robots: [Robot]
    let christmasTreeAscii = """
*******************************
*                             *
*                             *
*                             *
*                             *
*              *              *
*             ***             *
*            *****            *
*           *******           *
*          *********          *
*            *****            *
*           *******           *
*          *********          *
*         ***********         *
*        *************        *
*          *********          *
*         ***********         *
*        *************        *
*       ***************       *
*      *****************      *
*        *************        *
*       ***************       *
*      *****************      *
*     *******************     *
*    *********************    *
*             ***             *
*             ***             *
*             ***             *
*                             *
*                             *
*                             *
*                             *
*******************************
"""
    let christmasTree: [String]

    init(_ data: String, width: Int, height: Int) {
        robots = data.split(separator: "\n")
            .map { Robot(String($0), width: width, height: height) }
        christmasTree = christmasTreeAscii.split(separator: "\n")
            .map { String($0) }
    }

    func tick(count: Int) {
        for _ in 0..<count {
            for i in robots.indices {
                robots[i].tick()
            }
        }
    }

    func sum() -> Int {
        var results = [0, 0, 0, 0]

        for i in robots.indices {
            let quadrant = robots[i].quadrant()
            if quadrant >= 0 {
                results[quadrant] += 1
            }
        }

        return results.reduce(1, *)
    }

    func findChristmasTree() -> Int {
        var result = 0
        while !treeFound() {
            tick(count: 1)
            result += 1
        }

        return result
    }

    func treeFound() -> Bool {
        var pictureArray: [[Character]] = Array(repeating: Array(repeating: " ", count: 101), count: 103)
        for i in robots.indices {
            if pictureArray[robots[i].py][robots[i].px] == "*" {
                // Skip overlapps (might not work for every input?)
                return false
            }

            pictureArray[robots[i].py][robots[i].px] = "*"
        }
        let picture = pictureArray.map { String($0) }

        for row in christmasTree {
            var found = false
            for pictureRow in picture {
                if pictureRow.contains(row) {
                    found = true
                    break
                }
            }
            if !found {
                return false
            }
        }

        return true
    }
}
