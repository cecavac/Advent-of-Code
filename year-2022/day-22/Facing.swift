//
//  Facing.swift
//  Advent22
//
//  Created by Dragan Cecavac on 22.12.22.
//

import Foundation

enum Facing: Int {
    case Right = 0
    case Down = 1
    case Left = 2
    case Up = 3

    mutating func rotate(to : String) {
        if to == "L" {
            switch self {
            case .Up:
                self = .Left
            case .Left:
                self = .Down
            case .Down:
                self = .Right
            case .Right:
                self = .Up
            }
        } else if to == "R" {
            switch self {
            case .Up:
                self = .Right
            case .Left:
                self = .Up
            case .Down:
                self = .Left
            case .Right:
                self = .Down
            }
        } else {
            print("Unknown rotate command: \(to)")
        }
    }
}
