//
//  Raindeer.swift
//  Advent14
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Raindeer {
    private let speed: Int
    private let runTime: Int
    private let restTime: Int

    private(set) var mileage = 0
    private(set) var points = 0
    private var timeToRun:Int;
    private var timeToRest = 0

    init(by speed:Int, for runTime:Int, wait restTime:Int) {
        self.speed = speed
        self.runTime = runTime
        self.restTime = restTime

        timeToRun = runTime
    }

    public func tick() {
        if timeToRun > 0 {
            mileage += speed
            timeToRun -= 1

            if timeToRun == 0 {
                timeToRest = restTime
            }
        } else {
            timeToRest -= 1

            if timeToRest == 0 {
                timeToRun = runTime
            }
        }
    }

    public func praise() {
        points += 1
    }
}
