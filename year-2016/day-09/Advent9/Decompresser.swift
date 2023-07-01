//
//  Decompresser.swift
//  Advent9
//
//  Created by Dragan Cecavac on 22.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Decompresser {
    private enum State {
        case COPY
        case MARKER1
        case MARKER2
        case EXPAND
    }

    private var state = State.COPY

    public func process(input: String) -> String {
        let data = Array(input)
        var output = ""
        var marker1 = ""
        var marker2 = ""
        var skip = 0

        state = State.COPY

        for i in 0..<data.count {
            switch state {
            case .COPY:
                if data[i] == "(" {
                    state = .MARKER1
                } else {
                    output += String(data[i])
                }
            case .MARKER1:
                if data[i] == "x" {
                    state = .MARKER2
                } else {
                    marker1 += String(data[i])
                }
            case .MARKER2:
                if data[i] == ")" {
                    state = .EXPAND

                    let sectionLength = Int(marker1)!
                    let repeatCount = Int(marker2)!
                    marker1 = ""
                    marker2 = ""

                    var section = ""
                    for j in i + 1...i + sectionLength {
                        section += String(data[j])
                    }

                    for _ in 0..<repeatCount {
                        output += section
                    }

                    skip = i + sectionLength
                } else {
                    marker2 += String(data[i])
                }
            case .EXPAND:
                if i == skip {
                    state = .COPY
                }
            }
        }

        return output
    }

    private func needsExpansion(_ input: String) -> Bool {
        let data = Array(input)

        for char in data {
            if char == "(" {
                return true
            }
        }

        return false
    }

    public func fullExpander(input: String) -> Int {
        var stringSection = input
        var length = 0

        while (needsExpansion(stringSection)) {
            stringSection = process(input: stringSection)
        }

        length = stringSection.count

        return length
    }

    public func expandProcess(input: String, depth: Int) -> Int {
        let data = Array(input)
        var marker1 = ""
        var marker2 = ""
        var skip = 0
        var length = 0

        var subsections:[String] = []
        var repeatings:[Int] = []

        for i in 0..<data.count {
            switch state {
            case .COPY:
                if data[i] == "(" {
                    state = .MARKER1
                } else {
                    length += 1
                }
            case .MARKER1:
                if data[i] == "x" {
                    state = .MARKER2
                } else {
                    marker1 += String(data[i])
                }
            case .MARKER2:
                if data[i] == ")" {
                    state = .EXPAND

                    let sectionLength = Int(marker1)!
                    let repeatCount = Int(marker2)!
                    marker1 = ""
                    marker2 = ""

                    var section = ""
                    for j in i + 1...i + sectionLength {
                        section += String(data[j])
                    }

                    subsections.append(section)
                    repeatings.append(repeatCount)

                    skip = i + sectionLength
                } else {
                    marker2 += String(data[i])
                }
            case .EXPAND:
                if i == skip {
                    state = .COPY
                }
            }
        }

        for i in 0..<subsections.count {
            var sublength: Int

            if (depth == 0) {
                sublength = fullExpander(input: subsections[i])
            } else {
                sublength = expandProcess(input: subsections[i], depth: depth - 1)
            }
            length += sublength * repeatings[i]
        }

        return length
    }
}
