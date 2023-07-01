//
//  improvedVisitTracker.swift
//  Advent3
//
//  Created by Dragan Cecavac on 05.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

enum Turn {
    case Santa
    case Robot

    public func nextTurn() -> Turn {
        switch(self) {
        case .Santa:
            return .Robot
        case .Robot:
            return .Santa
        }
    }
}

class ImprovedVisitTracker: VisitTracker
{
    var santaI: Int64 = 100000
    var santaJ: Int64 = 100000
    var robotI: Int64 = 100000
    var robotJ: Int64 = 100000
    private var turn = Turn.Santa

    private func getPosition(positionSanta santa:Int64, positionRobot robot:Int64) -> Int64 {
        switch(turn) {
        case .Santa:
            return santa
        case .Robot:
            return robot
        }
    }

    override var positionI: Int64 {
        get {
            return getPosition(positionSanta: santaI, positionRobot: robotI)
        }

        set {
            switch(turn) {
            case .Santa:
                santaI = newValue
            case .Robot:
                robotI = newValue
            }
        }
    }

    override var positionJ: Int64 {
        get {
            return getPosition(positionSanta: santaJ, positionRobot: robotJ)
        }

        set {
            switch(turn) {
            case .Santa:
                santaJ = newValue
            case .Robot:
                robotJ = newValue
            }
        }
    }

    override func visitCurrent() {
        if let visits = map[positionHash] {
            map[positionHash] = visits + 1
        } else {
            map[positionHash] = 1
        }

        turn = turn.nextTurn()
    }
}
