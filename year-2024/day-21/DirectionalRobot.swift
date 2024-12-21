//
//  DirectionalRobot.swift
//  day-21
//
//  Created by Dragan Cecavac on 21.12.24.
//

class DirectionalRobot {
    var i = 0
    var j = 2

    func decode(key: Character) -> (Int, Int) {
        switch key {
        case "^":
            return (0, 1)
        case "A":
            return (0, 2)
        case "<":
            return (1, 0)
        case "v":
            return (1, 1)
        case ">":
            return (1, 2)

        default:
            fatalError("Invalid key \(key)")
        }
    }

    func enter(_ data: String) -> [String] {
        var results = [String]()
        for character in data {
            var result = ""
            let oldI = i
            let oldJ = j
            (i, j) = decode(key: character)

            // Experimentally fine-tuned part2 minimum, while still valid for part 1
            if oldI == 1 && oldJ == 0 {
                // Starting from <

                if i == 0 && j == 1 {
                    // ^
                    result = ">^A"
                } else if i == 0 && j == 2 {
                    // A
                    result = ">>^A"
                } else if i == 1 && j == 1 {
                    // v
                    result = ">A"
                } else if i == 1 && j == 0 {
                    // <
                    result = "A"
                } else if i == 1 && j == 2 {
                    // >
                    result = ">>A"
                } else {
                    fatalError("Invalid option")
                }
            } else if oldI == 0 && oldJ == 2 {
                // Starting from A

                if i == 0 && j == 1 {
                    // ^
                    result = "<A"
                } else if i == 0 && j == 2 {
                    // A
                    result = "A"
                } else if i == 1 && j == 1 {
                    // v
                    result = "<vA"
                } else if i == 1 && j == 0 {
                    // <
                    result = "v<<A"
                } else if i == 1 && j == 2 {
                    // >
                    result = "vA"
                } else {
                    fatalError("Invalid option")
                }
            } else if oldI == 0 && oldJ == 1 {
                // Starting from ^

                if i == 0 && j == 1 {
                    // ^
                    result = "A"
                } else if i == 0 && j == 2 {
                    // A
                    result = ">A"
                } else if i == 1 && j == 1 {
                    // v
                    result = "vA"
                } else if i == 1 && j == 0 {
                    // <
                    result = "v<A"
                } else if i == 1 && j == 2 {
                    // >
                    result = "v>A"
                } else {
                    fatalError("Invalid option")
                }
            } else if oldI == 1 && oldJ == 1 {
                // Starting from v

                if i == 0 && j == 1 {
                    // ^
                    result = "^A"
                } else if i == 0 && j == 2 {
                    // A
                    result = "^>A"
                } else if i == 1 && j == 1 {
                    // v
                    result = "A"
                } else if i == 1 && j == 0 {
                    // <
                    result = "<A"
                } else if i == 1 && j == 2 {
                    // >
                    result = ">A"
                } else {
                    fatalError("Invalid option")
                }
            } else if oldI == 1 && oldJ == 2 {
                // Starting from >

                if i == 0 && j == 1 {
                    // ^
                    result = "<^A"
                } else if i == 0 && j == 2 {
                    // A
                    result = "^A"
                } else if i == 1 && j == 1 {
                    // v
                    result = "<A"
                } else if i == 1 && j == 0 {
                    // <
                    result = "<<A"
                } else if i == 1 && j == 2 {
                    // >
                    result = "A"
                } else {
                    fatalError("Invalid option")
                }
            } else {
                fatalError("Invalid option")
            }

            results.append(result)
        }

        return results
    }
}
