//
//  Hasher.swift
//  Advent4
//
//  Created by Dragan Cecavac on 06.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation
import CryptoKit

class Hasher
{
    private static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    public static func withNLeadingZeros(_ input: String, zeros n: Int) -> Bool {
        let prefix = input.prefix(n)
        for c in prefix {
            if c != "0" {
                return false
            }
        }

        return true
    }

    public static func findFirstWithNLeadingZeros(for input: String, zeros n: Int) -> Int {
        var index = -1
        var md5Digest: String

        repeat {
            index += 1
            let md5Input = "\(input)\(index)"
            md5Digest = MD5(string: md5Input)
        } while !withNLeadingZeros(md5Digest, zeros: n)

        return index
    }
}
