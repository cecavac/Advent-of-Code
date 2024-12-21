//
//  NumericRobot.swift
//  day-21
//
//  Created by Dragan Cecavac on 21.12.24.
//

class NumericRobot {
    var i = 3
    var j = 2

    var combinations = [[Character]]()

    init() {
        let moves = ["<", ">", "v", "^"]

        for move in moves {
            combinations.append(Array(move))
        }

        for move1 in moves {
            for move2 in moves {
                combinations.append(Array(move1 + move2))
            }
        }

        for move1 in moves {
            for move2 in moves {
                for move3 in moves {
                    combinations.append(Array(move1 + move2 + move3))
                }
            }
        }

        for move1 in moves {
            for move2 in moves {
                for move3 in moves {
                    for move4 in moves {
                        combinations.append(Array(move1 + move2 + move3 + move4))
                    }
                }
            }
        }

        for move1 in moves {
            for move2 in moves {
                for move3 in moves {
                    for move4 in moves {
                        for move5 in moves {
                            combinations.append(Array(move1 + move2 + move3 + move4 + move5))
                        }
                    }
                }
            }
        }
    }

    func decode(key: Character) -> (Int, Int) {
        switch key {
        case "7":
            return (0, 0)
        case "8":
            return (0, 1)
        case "9":
            return (0, 2)
        case "4":
            return (1, 0)
        case "5":
            return (1, 1)
        case "6":
            return (1, 2)
        case "1":
            return (2, 0)
        case "2":
            return (2, 1)
        case "3":
            return (2, 2)
        case "0":
            return (3, 1)
        case "A":
            return (3, 2)


        default:
            fatalError("Invalid key \(key)")
        }
    }

    func isLegal(candidate: [Character], oldI: Int, oldJ: Int) -> Bool {
        var ii = oldI
        var jj = oldJ

        for character in candidate {
            switch character {
            case "^":
                ii -= 1
            case "<":
                jj -= 1
            case "v":
                ii += 1
            case ">":
                jj += 1

            default:
                fatalError("Invalid key \(character)")
            }

            if ii == 3 && jj == 0 {
                return false
            }
        }

        return true
    }

    func enter(_ data: String) -> [[String]] {
        var results = [[String]]()

        for character in data {
            let oldI = i
            let oldJ = j
            (i, j) = decode(key: character)

            let countVertical = (abs(oldI - i))
            var vertical: Character = "v"
            if i < oldI {
                vertical = "^"
            }

            let countHorizontal = (abs(oldJ - j))
            var horizontal: Character = ">"
            if j < oldJ {
                horizontal = "<"
            }

            var candidates = [[Character]]()
            for combination in combinations {
                if combination.count != countVertical + countHorizontal {
                    continue
                }

                let cv = combination.filter { $0 == vertical }.count
                if cv != countVertical {
                    continue
                }

                let ch = combination.filter { $0 == horizontal }.count
                if ch != countHorizontal {
                    continue
                }

                candidates.append(combination)
            }

            var legal = [String]()
            for candidate in candidates {
                if isLegal(candidate: candidate, oldI: oldI, oldJ: oldJ) {
                    var legalCandidate = candidate
                    legalCandidate.append("A")
                    legal.append(String(legalCandidate))
                }
            }

            if legal.count == 0 {
                legal.append("A")
            }
            results.append(legal)
        }

        return results
    }
}
