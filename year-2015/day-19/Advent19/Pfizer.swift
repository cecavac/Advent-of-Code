//
//  Pfizer.swift
//  Advent19
//
//  Created by Dragan Cecavac on 30.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Pfizer {
    struct Replacement {
        let input: String
        let output: String
    }

    var replacements: [Replacement] = []
    var molecule: String

    init(for source: String, with list: String) {
        molecule = source
        let lines = list.split(separator: "\n")
        for line in lines {
            let words = line.split(separator: " ")
            let replacement = Replacement(input: String(words[0]), output: String(words[2]))
            replacements.append(replacement)
        }
    }

    func calibrate() -> Int {
        let components = Array(molecule)
        var outputs: Set<String> = Set()
        for i in 0..<components.count {
            for replacement in replacements {
                if i + replacement.input.count > components.count {
                    continue
                }

                var input = ""
                for j in 0..<replacement.input.count {
                    input += String(components[i + j])
                }

                if input == replacement.input {
                    let output = String(molecule.prefix(i)) + replacement.output + String(molecule.suffix(molecule.count - i - replacement.input.count))
                    outputs.insert(output)
                }
            }
        }

        return outputs.count
    }

    private func isBaseProduct(_ product: String) -> Bool {
        for character in product {
            if character != "e" {
                return false
            }
        }

        return true
    }

    var failedProduction: Set<String> = Set()

    func dig(_ input: String, depth: Int) -> Int {
        let components = Array(input)

        let reversedInput = input.reversed()
        let reversed = Array(reversedInput)

        for i in 0..<components.count {
            for replacement in replacements {
                if i + replacement.output.count <= components.count {
                    var output = ""
                    for j in 0..<replacement.output.count {
                        output += String(components[i + j])
                    }

                    if output == replacement.output {
                        let reducedInput = String(input.prefix(i)) + replacement.input + String(input.suffix(input.count - i - replacement.output.count))

                        if reducedInput == "e" {
                            return depth + 1
                        } else if !failedProduction.contains(reducedInput) {
                            let result = dig(reducedInput, depth: depth + 1)
                            if result > 0 {
                                return result
                            } else {
                                failedProduction.insert(reducedInput)
                            }
                        }
                    }
                }

                if i + replacement.output.count <= reversed.count {
                    var output = ""
                    for j in 0..<replacement.output.count {
                        output += String(reversed[i + j])
                    }

                    if output == String(replacement.output.reversed()) {
                        let reversedReducedInput = String(reversedInput.prefix(i)) + String(replacement.input.reversed()) + String(reversedInput.suffix(reversedInput.count - i - replacement.output.count))
                        let reducedInput = String(reversedReducedInput.reversed())

                        if reducedInput == "e" {
                            return depth + 1
                        } else if !failedProduction.contains(reducedInput) {
                            let result = dig(reducedInput, depth: depth + 1)
                            if result > 0 {
                                return result
                            } else {
                                failedProduction.insert(reducedInput)
                            }
                        }
                    }
                }
            }
        }

        return 0
    }

    func produce() -> Int {
        return dig(molecule, depth: 0)
    }
}
