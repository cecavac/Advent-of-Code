//
//  Depth.swift
//  Advent01
//
//  Created by Dragan Cecavac on 01.12.21.
//

import Foundation

class 🛳 {
    public static func increaseCount(_ 📑: String, 🪟: Int) -> Int {
        let 💿 = 📑.split(separator: "\n")
        var 🤩 = 0

        for 🔁 in 🪟..<💿.count {
            let 💦 = Int(String(💿[🔁 - 🪟]))!
            let 🐳 = Int(String(💿[🔁]))!

            if 🐳 > 💦 {
                🤩 += 1
            }
        }

        return 🤩
    }
}
