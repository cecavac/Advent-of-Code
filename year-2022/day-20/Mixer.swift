//
//  Mixer.swift
//  Advent20
//
//  Created by Dragan Cecavac on 20.12.22.
//

import Foundation

class Mixer {
    var numbers = [Number]()
    var zero = Number(value: 0, id: -1)

    init(_ input: String, decriptionKey: Int?) {
        let lines = input.split(separator: "\n")
        for i in lines.indices {
            let value = Int(String(lines[i]))!
            let number: Number
            if let key = decriptionKey {
                number = Number(value: value * key, id: i)
            } else {
                number = Number(value: value, id: i)
            }

            numbers.append(number)
            if number.value == 0 {
                zero = number
            }
        }
    }

    func mix(cycles: Int) -> Int {
        var mixedNumbers = numbers
        for _ in 0..<cycles {
            for number in numbers {
                let index = mixedNumbers.firstIndex(of: number)!

                mixedNumbers.remove(at: index)
                var newIndex = index + number.value

                newIndex %= mixedNumbers.count
                if newIndex < 0 {
                    newIndex += mixedNumbers.count
                }

                mixedNumbers.insert(number, at: newIndex)
            }
        }

        let i0 = mixedNumbers.firstIndex(of: zero)!
        let i1 = (i0 + 1000) % mixedNumbers.count
        let i2 = (i0 + 2000) % mixedNumbers.count
        let i3 = (i0 + 3000) % mixedNumbers.count

        return mixedNumbers[i1].value + mixedNumbers[i2].value + mixedNumbers[i3].value
    }
}
