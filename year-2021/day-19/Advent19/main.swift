//
//  main.swift
//  Advent19
//
//  Created by Dragan Cecavac on 19.12.21.
//

import Foundation

print("Patience is a virtue!")

let beaconScanner = BeaconScanner(Input.Input1)
beaconScanner.groupFrist2Pairs()
beaconScanner.groupScanners()
beaconScanner.collectBeacons()

let result1 = beaconScanner.beacons.count
print("Result1: \(result1)")

let result2 = beaconScanner.maxDistance()
print("Result2: \(result2)")
