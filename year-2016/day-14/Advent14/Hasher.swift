//
//  Hasher.swift
//  Advent14
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

import Foundation
import CryptoKit

class Hasher
{
    var cache: [String] = []
    let salt: String

    init(_ input: String) {
        salt =  input
    }

    private static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    private static func MD5(string: String, keyStretching: Bool) -> String {
        var output = MD5(string: string)

        if keyStretching {
            for _ in 0..<2016 {
                output = MD5(string: output)
            }
        }

        return output
    }

    private func charactesInARow(hash input: String, characters n: Int) -> Character? {
        let data = Array(input)
        let endOffset = n - 1

        for i in 0..<data.count - endOffset {
            var same = true
            for j in i + 1...i + endOffset {
                same = same && data[i] == data[j]
            }

            if same {
                return data[i]
            }
        }

        return nil
    }

    private func charactesInARow(hash input: String, characters n: Int, targetCharacter: Character) -> Bool {
        let data = Array(input)
        let endOffset = n - 1

        for i in 0..<data.count - endOffset {
            if data[i] == targetCharacter {
                var same = true

                for j in i + 1...i + endOffset {
                    same = same && targetCharacter == data[j]
                }

                if same {
                    return true
                }
            }
        }

        return false
    }

    func find(index n: Int, keyStretching: Bool) -> Int {
        for i in 0...1001 {
            let hash = Hasher.MD5(string: "\(salt)\(i)", keyStretching: keyStretching)
            cache.append(hash)
            print ("Preparing cache \(i)/1001")
        }

        var index = 0
        var found = 0

        while found < n {
            if let repeatingCharacter = charactesInARow(hash: cache[0], characters: 3) {
                for i in 1..<cache.count {
                    if charactesInARow(hash: cache[i], characters: 5, targetCharacter: repeatingCharacter) {
                        found += 1
                        print("Found indexes \(found)/\(n)")
                        break
                    }
                }
            }

            index += 1
            let offsettedIndex = index + cache.count
            let hash = Hasher.MD5(string: "\(salt)\(offsettedIndex)", keyStretching: keyStretching)
            cache.remove(at: 0)
            cache.append(hash)
        }

        return index
    }
}
