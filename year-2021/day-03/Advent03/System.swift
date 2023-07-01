//
//  System.swift
//  Advent03
//
//  Created by Dragan Cecavac on 03.12.21.
//

import Foundation

class System {
    var data: [Int] = []
    let digits: Int

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        digits = lines.first!.count
        for line in lines {
            data.append(Int(String(line), radix: 2)!)
        }
    }

    private func isOneTheMostCommon(_ input:[Int], at position: Int) -> Bool {
        var ones = 0
        for element in input {
            ones += (element >> (digits - position)) & 0x1
        }
        let zeros = input.count - ones

        return ones >= zeros
    }

    func power() -> UInt64 {
        var gamma: UInt64 = 0
        var epsylon: UInt64 = 0

        for i in 1...digits {
            gamma *= 2
            epsylon *= 2

            if isOneTheMostCommon(data, at: i) {
                gamma += 1
            } else {
                epsylon += 1
            }
        }

        return gamma * epsylon
    }

    private func supportParameter(_ defaultMode: Bool) -> Int {
        var localData = data

        for i in 1...digits {
            var newData = [Int]()

            let keepOnes = isOneTheMostCommon(localData, at: i);
            for element in localData {
                let isOne = ((element >> (digits - i)) & 0x1) == 0x1

                if defaultMode {
                    if isOne ==  keepOnes {
                        newData.append(element)
                    }
                } else {
                    if isOne !=  keepOnes {
                        newData.append(element)
                    }
                }
            }

            localData = newData

            if localData.count == 1 {
                break
            }
        }

        return localData.first!
    }

    func lifeSupportRating() -> Int {
        let oxygenRating = supportParameter(true)
        let co2Rating = supportParameter(false)

        return oxygenRating * co2Rating
    }
}
