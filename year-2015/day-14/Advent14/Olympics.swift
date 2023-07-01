//
//  Olympics.swift
//  Advent14
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Olympics {
    private var raindeers:[Raindeer] = []

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let words = line.split(separator: " ")

            let speed = Int(words[3])!
            let runTime = Int(words[6])!
            let restTime = Int(words[13])!

            let raindeer = Raindeer(by: speed, for: runTime, wait: restTime)
            raindeers.append(raindeer)
        }
    }

    public func findBest(after iterations:Int) -> (Int, Int) {
        var mileage = Int.min
        var points =  Int.min

        for _ in 1...iterations {
            for raindeer in raindeers {
                raindeer.tick()
            }

            var leadMileage = Int.min
            for raindeer in raindeers {
                leadMileage = max(leadMileage, raindeer.mileage)
            }

            for raindeer in raindeers {
                if raindeer.mileage == leadMileage {
                    raindeer.praise()
                }
            }
        }

        for raindeer in raindeers {
            mileage = max(mileage, raindeer.mileage)
            points = max(points, raindeer.points)
        }

        return (mileage, points)
    }
}
