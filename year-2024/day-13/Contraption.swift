//
//  Contraption.swift
//  day-13
//
//  Created by Dragan Cecavac on 13.12.24.
//

class Contraption {
    let claws: [Claw]

    init(_ data: String) {
        claws = data.split(separator: "\n\n")
                .map { Claw(String($0)) }
    }

    func tokens(boosted: Bool) -> Int {
        return claws.map{ $0.score(boosted: boosted) }
            .reduce(0, +)
    }
}
