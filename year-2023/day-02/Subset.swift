//
//  Subset.swift
//  day-02
//
//  Created by Dragan Cecavac on 02.12.23.
//

import Foundation

class Subset {
    var red = 0
    var green = 0
    var blue = 0

    init(_ input: String) {
        let adaptedData = input.replacingOccurrences(of: ",", with: "")
        let data = adaptedData.split(separator: " ")

        for i in stride(from: 0, to: data.count, by: 2) {
            if data [i + 1] == "red" {
                red = Int(String(data[i]))!
            }
            if data [i + 1] == "green" {
                green = Int(String(data[i]))!
            }
            if data [i + 1] == "blue" {
                blue = Int(String(data[i]))!
            }
        }
    }

    func isValid() -> Bool {
        return red <= 12 && green <= 13 && blue <= 14
    }
}
