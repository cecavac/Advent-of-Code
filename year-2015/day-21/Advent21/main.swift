//
//  main.swift
//  Advent21
//
//  Created by Dragan Cecavac on 10.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let game = Game(bossData: Input.Boss, weaponData: Input.Weapons, armorData: Input.Armor, ringsData: Input.Rings)
let result = game.play()
print("Result1: \(result.0)")
print("Result2: \(result.1)")
