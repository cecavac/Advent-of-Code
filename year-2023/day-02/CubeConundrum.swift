//
//  CubeConundrum.swift
//  day-02
//
//  Created by Dragan Cecavac on 02.12.23.
//

class CubeConundrum {
    var games = [Game]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            games.append(Game(String(line)))
        }
    }

    func validate() -> Int {
        return games.filter { $0.isValid() }
            .map{ $0.id }
            .reduce(0, +)
    }

    func powerSum() -> Int {
        return games.map { $0.power() }
            .reduce(0, +)
    }
}
