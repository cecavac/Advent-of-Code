//
//  Direction.swift
//  day-16
//
//  Created by Dragan Cecavac on 16.12.23.
//

import Foundation

enum Direction {
    case UP
    case LEFT
    case DOWN
    case RIGHT

    func offsets() -> (Int, Int) {
        switch self {
        case .UP:
            return (-1, 0)
        case .LEFT:
            return (0, -1)
        case .DOWN:
            return (1, 0)
        case .RIGHT:
            return (0, 1)
        }
    }

    func handleCorner(field: Character) -> Direction {
        switch self {
        case .UP:
            if field == "/" {
                return .RIGHT
            } else {
                return .LEFT
            }
        case .LEFT:
            if field == "/" {
                return .DOWN
            } else {
                return .UP
            }
        case .DOWN:
            if field == "/" {
                return .LEFT
            } else {
                return .RIGHT
            }
        case .RIGHT:
            if field == "/" {
                return .UP
            } else {
                return .DOWN
            }
        }
    }
}
