//
//  BrightnessLights.swift
//  Advent6
//
//  Created by Dragan Cecavac on 13.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class BrightnessLights: Lights {
    override func toggle(xStart i1: Int, yStart j1: Int, xEnd i2: Int, yEnd j2: Int) {
        for i in i1...i2 {
            for j in j1...j2 {
                lights[i][j] += 2
            }
        }
    }

    override func setLight(xStart i1: Int, yStart j1: Int, xEnd i2: Int, yEnd j2: Int, state value: Int) {
        for i in i1...i2 {
            for j in j1...j2 {
                lights[i][j] += value
                if (lights[i][j] < 0) {
                    lights[i][j] = 0
                }
            }
        }
    }

    override func turnOn(xStart: Int, yStart: Int, xEnd: Int, yEnd: Int) {
        setLight(xStart: xStart, yStart: yStart, xEnd: xEnd, yEnd: yEnd, state: 1)
    }

    override func turnOff(xStart: Int, yStart: Int, xEnd: Int, yEnd: Int) {
        setLight(xStart: xStart, yStart: yStart, xEnd: xEnd, yEnd: yEnd, state: -1)
    }
}
