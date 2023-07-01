//
//  Network.swift
//  Advent7
//
//  Created by Dragan Cecavac on 09.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Network {
    private(set) var result1 = 0
    private(set) var result2 = 0

    private static func containsBaseABBA(_ input:String) -> Bool {
        let mainArray = Array(input)
        for i in 0..<(mainArray.count - 3) {
            let a = mainArray[i]
            let b = mainArray[i + 1]
            let c = mainArray[i + 2]
            let d = mainArray[i + 3]

            if a != "-" && b != "-" && c != "-" && d != "-" &&
                a == d && b == c && a != b {
                return true
            }
        }

        return false
    }

    private static func containsABBA(supernet sn:String, hypernet hn: String) -> Bool {
        return Network.containsBaseABBA(sn) && !Network.containsBaseABBA(hn)
    }

    private static func baseABA(_ input:String) -> Set<String> {
        var result = Set<String>()

        let mainArray = Array(input)
        for i in 0..<(mainArray.count - 2) {
            let a = mainArray[i]
            let b = mainArray[i + 1]
            let c = mainArray[i + 2]

            if a != "-" && b != "-" && c != "-" &&
                a == c && a != b {
                let element = "\(a)\(b)\(c)"
                result.insert(element)
            }
        }

        return result
    }

    private static func containsABA(supernet sn:String, hypernet hn: String) -> Bool {
        let supernetABA = baseABA(sn)
        let hypernetABA = baseABA(hn)

        for input in supernetABA {
            let array = Array(input)
            let a = array[0]
            let b = array[1]

            let inversed = "\(b)\(a)\(b)"
            if hypernetABA.contains(inversed) {
                return true
            }
        }

        return false
    }

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var supernetLine = ""
            var hypernetLine = ""
            var readingHypernet = false

            for character in line {
                if character == "[" {
                    readingHypernet = true

                    supernetLine += "-"
                    hypernetLine += "-"
                } else if character == "]" {
                    readingHypernet = false
                } else {
                    if readingHypernet {
                        hypernetLine += String(character)
                    } else {
                        supernetLine += String(character)
                    }
                }
            }

            if Network.containsABBA(supernet: supernetLine, hypernet: hypernetLine) {
                result1 += 1
            }

            if Network.containsABA(supernet: supernetLine, hypernet: hypernetLine) {
                result2 += 1
            }
        }
    }
}
