//
//  Investigator.swift
//  Advent16
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Investigator {
    let target:Aunt
    var aunts:[Aunt] = []

    init(mfcsam targetData: String, memoryData database: String) {
        target = Aunt(mfcsam: targetData)

        let lines = database.split(separator: "\n")
        for line in lines {
            let aunt = Aunt(fromMemory: String(line))
            aunts.append(aunt)
        }
    }

    func findFitting() -> Int? {
        for aunt in aunts {
            if aunt.fitting(description: target) {
                return aunt.id
            }
        }

        return nil
    }

    func findRealFitting() -> Int? {
        for aunt in aunts {
            if aunt.realFitting(description: target) {
                return aunt.id
            }
        }

        return nil
    }
}
