//
//  String.swift
//  Advent5
//
//  Created by Dragan Cecavac on 12.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

extension String {
    public func isNice() -> Bool {
        var vowelCount = 0
        var doubleCharacter = false
        let vowels = ["a", "e", "i", "o", "u"]
        let naughtySubstrings = ["ab", "cd", "pq", "xy"]

        for character in self {
            if vowels.contains(String(character)) {
                vowelCount += 1
            }
        }
        if vowelCount < 3 {
            return false
        }

        for i in 0..<(self.count - 1) {
            let startIndex = self.startIndex
            let firstCharIndex = self.index(startIndex, offsetBy: i)
            let secondCharIndex = self.index(startIndex, offsetBy: i + 1)
            if self[firstCharIndex] == self[secondCharIndex] {
                doubleCharacter = true
                break;
            }
        }
        if !doubleCharacter {
            return false
        }

        for naughtySubstring in naughtySubstrings {
            if self.contains(naughtySubstring) {
                return false
            }
        }

        return true
    }

    public func isReallyNice() -> Bool {
        var pairRepeat = false

        for i in 0..<(self.count - 2) {
            let startIndex = self.startIndex
            let firstCharIndex = self.index(startIndex, offsetBy: i)
            let secondCharIndex = self.index(startIndex, offsetBy: i + 1)
            let thirdCharIndex = self.index(startIndex, offsetBy: i + 2)
            let substring = self[firstCharIndex...secondCharIndex]
            let substringPrefix = self.prefix(upTo: firstCharIndex)
            let substringSuffix = self.suffix(from: thirdCharIndex)
            if substringPrefix.contains(substring) || substringSuffix.contains(substring) {
                pairRepeat = true
                break
            }
        }
        if !pairRepeat {
            return false
        }

        for i in 0..<(self.count - 2) {
            let startIndex = self.startIndex
            let firstCharIndex = self.index(startIndex, offsetBy: i)
            let thirdCharIndex = self.index(startIndex, offsetBy: i + 2)
            if self[firstCharIndex] == self[thirdCharIndex] {
                return true
            }
        }

        return false
    }
}
