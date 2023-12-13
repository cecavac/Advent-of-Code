//
//  MirrorField.swift
//  day-13
//
//  Created by Dragan Cecavac on 13.12.23.
//

import Foundation

class MirrorField {
    var mirrors = [Mirror]()

    init(_ input: String) {
        for block in input.split(separator: "\n\n") {
            let mirror = Mirror(String(block))
            mirrors.append(mirror)
        }
    }

    func reflections() -> Int {
        return mirrors.map { $0.reflections()! }.reduce(0, +)
    }

    func smudgeReflections() -> Int {
        return mirrors.map { $0.smudgeReflections()! }.reduce(0, +)
    }
}
