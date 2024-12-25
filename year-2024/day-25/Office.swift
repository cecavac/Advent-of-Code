//
//  Office.swift
//  day-25
//
//  Created by Dragan Cecavac on 25.12.24.
//

class Office {
    var keys = [[Int]]()
    var locks = [[Int]]()
    let width = 5

    init(_ data: String) {
        let dotLine = String(Array(repeating: ".", count: width))
        let sharpLine = String(Array(repeating: "#", count: width))

        let items = data.split(separator: "\n\n")
        for item in items {
            let lines = item.split(separator: "\n")
            var values = Array(repeating: 0, count: width)

            for i in lines.indices {
                let row = Array(String(lines[i]))
                for j in row.indices {
                    if row[j] == "#" {
                        values[j] += 1
                    }
                }
            }

            if String(lines.first!) == dotLine && String(lines.last!) == sharpLine {
                keys.append(values)
            } else if String(lines.first!) == sharpLine && String(lines.last!) == dotLine {
                locks.append(values)
            } else {
                fatalError("Invalid item")
            }
        }
    }

    func unlock() -> Int {
        var result = 0

        for key in keys {
            for lock in locks {
                var valid = true
                for j in 0..<width {
                    if key[j] + lock[j] > 7 {
                        valid = false
                        break
                    }
                }
                if valid {
                    result += 1
                }
            }
        }

        return result
    }
}
