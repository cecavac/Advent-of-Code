//
//  CucumberField.swift
//  Advent25
//
//  Created by Dragan Cecavac on 25.12.21.
//

import Foundation

class CucumberField {
    var field = [[Character]]()
    var newField = [[Character]]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let row = Array(String(line))
            field.append(row)
        }
    }

    func changed() -> Bool {
        for i in field.indices {
            for j in field[i].indices {
                if field[i][j] != newField[i][j] {
                    return true
                }
            }
        }

        return false
    }

    func tick () {
        var intermediateField = field

        for i in field.indices {
            for j in field[i].indices {
                if field[i][j] == ">" && field[i][(j + 1) % field[i].count] == "." {
                    intermediateField[i][j] = "."
                    intermediateField[i][(j + 1) % field[i].count] = ">"
                }
            }
        }

        newField = intermediateField

        for i in intermediateField.indices {
            for j in intermediateField[i].indices {
                if intermediateField[i][j] == "v" && intermediateField[(i + 1) % intermediateField.count][j] == "." {
                    newField[i][j] = "."
                    newField[(i + 1) % intermediateField.count][j] = "v"
                }
            }
        }
    }

    func findStopTick() -> Int {
        var result = 0

        while true {
            result += 1
            tick()

            if !changed() {
                return result
            } else {
                field = newField
            }
        }
    }
}
