//
//  Recipe.swift
//  Advent15
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Recipe {
    struct Ingredient {
        var capacity: Int
        var durability: Int
        var flavor: Int
        var texture: Int
        var calories: Int
    }

    var ingredients: [Ingredient] = Array()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var lineWithoutCommas = ""
            for character in line {
                if character != "," {
                    lineWithoutCommas += String(character)
                }
            }

            let words = lineWithoutCommas.split(separator: " ")
            let ingredient = Ingredient(capacity: Int(words[2])!, durability: Int(words[4])!, flavor: Int(words[6])!, texture: Int(words[8])!, calories: Int(words[10])!)
            ingredients.append(ingredient)
        }
    }

    private func bestScore(focusOnTarget targetCondition: Bool, target caloriesTarget: Int) -> Int {
        var bestScore = 0

        for i in 0...100 {
            let jBound = 100 - i
            for j in 0...jBound {
                let kBound = jBound - j
                for k in 0...kBound {
                    let l = kBound - k
                    let depthI = 0
                    let depthJ = depthI + 1
                    let depthK = depthJ + 1
                    let depthL = depthK + 1

                    var capacity = i * ingredients[depthI].capacity
                    var durability = i * ingredients[depthI].durability
                    var flavor = i * ingredients[depthI].flavor
                    var texture = i * ingredients[depthI].texture
                    var calories = i * ingredients[depthI].calories

                    capacity += j * ingredients[depthJ].capacity
                    durability += j * ingredients[depthJ].durability
                    flavor += j * ingredients[depthJ].flavor
                    texture += j * ingredients[depthJ].texture
                    calories += j * ingredients[depthJ].calories

                    capacity += k * ingredients[depthK].capacity
                    durability += k * ingredients[depthK].durability
                    flavor += k * ingredients[depthK].flavor
                    texture += k * ingredients[depthK].texture
                    calories += k * ingredients[depthK].calories

                    capacity += l * ingredients[depthL].capacity
                    durability += l * ingredients[depthL].durability
                    flavor += l * ingredients[depthL].flavor
                    texture += l * ingredients[depthL].texture
                    calories += l * ingredients[depthL].calories

                    if capacity < 0 {
                        capacity = 0
                    }
                    if durability < 0 {
                        durability = 0
                    }
                    if flavor < 0 {
                        flavor = 0
                    }
                    if texture < 0 {
                        texture = 0
                    }
                    if targetCondition && calories != caloriesTarget {
                        continue
                    }

                    let score = capacity * durability * flavor * texture
                    bestScore = max(bestScore, score)
                }
            }
        }

        return bestScore
    }

    func bestScore(target caloriesTarget: Int) -> Int {
        return bestScore(focusOnTarget: true, target: caloriesTarget)
    }

    func bestScore() -> Int {
        return bestScore(focusOnTarget: false, target: 0)
    }
}
