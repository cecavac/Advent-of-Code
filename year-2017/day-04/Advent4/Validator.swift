//
//  Validator.swift
//  Advent4
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Validator {
    var passwords: [String] = []

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            passwords.append(String(line))
        }
    }

    public func countValid() -> Int {
        var valid = 0

        for password in passwords {
            var isValid = true
            let elements = password.split(separator: " ")

            for i in 0..<elements.count {
                for j in i + 1..<elements.count {
                    if elements[i] == elements[j] {
                        isValid = false
                        break
                    }
                }
            }

            if isValid {
                valid += 1
            }
        }

        return valid
    }

    public func secureCountValid() -> Int {
        var valid = 0

        for password in passwords {
            var isValid = true

            let elements = password.split(separator: " ")
            var sortedElements = Array<String>()

            for element in elements {
                let sortedElement = element.sorted()
                sortedElements.append(String(sortedElement))
            }

            for i in 0..<sortedElements.count {
                for j in i + 1..<sortedElements.count {
                    if sortedElements[i] == sortedElements[j] {
                        isValid = false
                        break
                    }
                }
            }

            if isValid {
                valid += 1
            }
        }

        return valid
    }
}
