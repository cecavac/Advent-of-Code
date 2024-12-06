//
//  Direction.swift
//  day-06
//
//  Created by Dragan Cecavac on 06.12.24.
//

enum Direction {
    case UP
    case DOWN
    case LEFT
    case RIGHT

    func next() -> Direction {
        switch self {
        case .UP:
            return Direction.RIGHT
        case .DOWN:
            return Direction.LEFT
        case .LEFT:
            return Direction.UP
        case .RIGHT:
            return Direction.DOWN
        }
    }
}
