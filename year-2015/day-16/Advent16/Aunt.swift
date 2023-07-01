//
//  Aunt.swift
//  Advent16
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Aunt {
    private var children:Int? = nil
    private var cats:Int? = nil
    private var samoyeds:Int? = nil
    private var pomeranians:Int? = nil
    private var akitas:Int? = nil
    private var vizslas:Int? = nil
    private var goldfish:Int? = nil
    private var trees:Int? = nil
    private var cars:Int? = nil
    private var perfumes:Int? = nil
    private(set) var id:Int

    private func initField(key category: String, value data: Int?) {
        switch (category) {
       case "children":
           children = data
       case "cats":
           cats = data
       case "samoyeds":
           samoyeds = data
       case "pomeranians":
           pomeranians = data
       case "akitas":
            akitas = data
        case "vizslas":
            vizslas = data
       case "goldfish":
           goldfish = data
       case "trees":
           trees = data
       case "cars":
           cars = data
       case "perfumes":
           perfumes = data
       default:
           print("Error parsing \(category)")
       }
    }

    init(mfcsam input: String) {
        id = 0
        let lines = input.split(separator: "\n")
        for line in lines {
            var adjustedLine = ""
            for character in line {
                if character != ":" && character != "," {
                    adjustedLine += String(character)
                }
            }
            let words = adjustedLine.split(separator: " ")
            initField(key: String(words[0]), value: Int(words[1]))
        }
    }

    init(fromMemory input: String) {
        var adjustedLine = ""
        for character in input {
            if character != ":" && character != "," {
                adjustedLine += String(character)
            }
        }

        let words = adjustedLine.split(separator: " ")
        id = Int(words[1])!
        initField(key: String(words[2]), value: Int(words[3]))
        initField(key: String(words[4]), value: Int(words[5]))
        initField(key: String(words[6]), value: Int(words[7]))
    }

    private let conditionNE: (Int, Int) -> Bool = { $0 != $1 }
    private let conditionGT: (Int, Int) -> Bool = { $0 >= $1 }
    private let conditionLT: (Int, Int) -> Bool = { $0 <= $1 }

    private let check: (Int?, Int?, (Int, Int) -> Bool) -> Bool = {
        if $0 != nil && $2($0!, $1!) {
            return false
        } else {
            return true
        }
    }

    func fitting(description target:Aunt) -> Bool {
        var result = true

        result = result && check(children, target.children, conditionNE)
        result = result && check(cats, target.cats, conditionNE)
        result = result && check(samoyeds, target.samoyeds, conditionNE)
        result = result && check(pomeranians, target.pomeranians, conditionNE)
        result = result && check(akitas, target.akitas, conditionNE)
        result = result && check(vizslas, target.vizslas, conditionNE)
        result = result && check(goldfish, target.goldfish, conditionNE)
        result = result && check(trees, target.trees, conditionNE)
        result = result && check(cars, target.cars, conditionNE)
        result = result && check(perfumes, target.perfumes, conditionNE)

        return result
    }

    func realFitting(description target:Aunt) -> Bool {
        var result = true

        result = result && check(children, target.children, conditionNE)
        result = result && check(cats, target.cats, conditionLT)
        result = result && check(samoyeds, target.samoyeds, conditionNE)
        result = result && check(pomeranians, target.pomeranians, conditionGT)
        result = result && check(akitas, target.akitas, conditionNE)
        result = result && check(vizslas, target.vizslas, conditionNE)
        result = result && check(goldfish, target.goldfish, conditionGT)
        result = result && check(trees, target.trees, conditionLT)
        result = result && check(cars, target.cars, conditionNE)
        result = result && check(perfumes, target.perfumes, conditionNE)

        return result
    }
}
