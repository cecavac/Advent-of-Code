//
//  Transform.swift
//  day-05
//
//  Created by Dragan Cecavac on 05.12.23.
//

import Foundation

struct Transform {
    let destination: Int
    let source: Int
    let length: Int

    func sourceToDestination(_ input: Int) -> Int? {
        if input >= source && input < (source + length) {
            let offset = input - source
            return destination + offset
        }

        return nil
    }

    func destinationToSource(_ input: Int) -> Int? {
        if input >= destination && input < (destination + length) {
            let offset = input - destination
            return source + offset
        }

        return nil
    }
}
