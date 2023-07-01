//
//  String.swift
//  Advent7
//
//  Created by Dragan Cecavac on 15.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

extension String {
    public func index(of substring:String) -> String.Index? {
        var charIndex = 0

        for character in self {
            if character == substring.first! {
                let currentCharIndex = index(self.startIndex, offsetBy: charIndex)
                let testedSubstringEndIndex = index(currentCharIndex, offsetBy: substring.count)
                let testedSubstring = self[currentCharIndex..<testedSubstringEndIndex]
                if testedSubstring == substring {
                    return currentCharIndex
                }
            }

            charIndex += 1
        }

        return nil
    }
}
