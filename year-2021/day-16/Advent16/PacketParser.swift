//
//  PacketParser.swift
//  Advent16
//
//  Created by Dragan Cecavac on 16.12.21.
//

import Foundation

class PacketParser {
    private(set) var value = 0
    private(set) var versionSum = 0

    private var counter = 0
    private var binaryInput = [Character]()

    init(_ input: String) {
        for char in input {
            binaryInput += charToBinary(char)
        }

        value = parsePacket()
    }

    private func parseHeader() -> Int {
        var version = String("\(binaryInput[counter])")
        version += String("\(binaryInput[counter + 1])")
        version += String("\(binaryInput[counter + 2])")
        counter += 3

        versionSum += binaryToDec(version)

        var id = String("\(binaryInput[counter])")
        id += String("\(binaryInput[counter + 1])")
        id += String("\(binaryInput[counter + 2])")
        counter += 3

        return binaryToDec(id)
    }

    private func parsePacket() -> Int {
        let id = parseHeader()
        if id == 4 {
            return parseLiteral()
        } else {
            let subPacketResults = parseOperator()
            var result: Int

            switch id {
            case 0:
                result = 0
                for element in subPacketResults {
                    result += element
                }
            case 1:
                result = 1
                for element in subPacketResults {
                    result *= element
                }
            case 2:
                result = Int.max
                for element in subPacketResults {
                    result = min(result, element)
                }
            case 3:
                result = 0
                for element in subPacketResults {
                    result = max(result, element)
                }
            case 5:
                if subPacketResults[0] > subPacketResults[1] {
                    result = 1
                } else {
                    result = 0
                }
            case 6:
                if subPacketResults[0] < subPacketResults[1] {
                    result = 1
                } else {
                    result = 0
                }
            case 7:
                if subPacketResults[0] == subPacketResults[1] {
                    result = 1
                } else {
                    result = 0
                }
            default :
                print("Unsupported id: \(id)")
                result = -1
            }

            return result
        }
    }

    private func parseLiteral() -> Int {
        var binaryData = [Character]()
        var moreData: Bool

        repeat {
            moreData = binaryInput[counter] == "1"
            counter += 1

            for _ in 0..<4 {
                binaryData.append(binaryInput[counter])
                counter += 1
            }
        } while moreData

        return binaryToDec(binaryData)
    }

    private func parseOperator() -> [Int] {
        var binaryData = [Character]()
        let lengthType = binaryInput[counter]
        counter += 1

        var binaryLength: Int
        if lengthType == "1" {
            binaryLength = 11
        } else {
            binaryLength = 15
        }

        for _ in 0..<binaryLength {
            binaryData.append(binaryInput[counter])
            counter += 1
        }

        var subpacketResults = [Int]()
        let length = binaryToDec(binaryData)
        if lengthType == "1" {
            for _ in 0..<length {
                subpacketResults.append(parsePacket())
            }
        } else {
            let endCounter = counter + length
            while counter < endCounter {
                subpacketResults.append(parsePacket())
            }
        }

        return subpacketResults
    }

    private func binaryToDec(_ input: [Character]) -> Int {
        let binaryString = String(input)
        return Int(binaryString, radix: 2)!
    }

    private func binaryToDec(_ input: String) -> Int {
        return binaryToDec(Array(input))
    }

    private func hexToBinary(_ input: [Character]) -> String {
        let hexString = String(input)
        return String(Int(hexString, radix: 16)!, radix: 2)
    }

    private func hexToBinary(_ input: String) -> String {
        return hexToBinary(Array(input))
    }

    private func charToBinary(_ input: Character) -> [Character] {
        var string = hexToBinary("\(input)")
        let padding = (4 - string.count % 4) % 4

        for _ in 0..<padding {
            string = "0\(string)"
        }

        return Array(string)
    }
}
