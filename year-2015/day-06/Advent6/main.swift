//
//  main.swift
//  Advent6
//
//  Created by Dragan Cecavac on 13.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let lights = Lights()
let brightnessLights = BrightnessLights()
let commands = Inputs.Input1.split(separator: "\n")
for command in commands {
    lights.command(String(command))
    brightnessLights.command(String(command))
}

print("Result1: \(lights.lightsOn)")
print("Result2: \(brightnessLights.lightsOn)")
