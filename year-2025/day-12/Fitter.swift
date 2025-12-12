//
//  Fitter.swift
//  day-12
//
//  Created by Dragan Cecavac on 12.12.25.
//

class Fitter {
    let spaces: Array<Space>

    init(_ data: String) {
        var elements = data.split(separator: "\n\n")

        let presents = elements.map { Present(String($0)) }

        spaces = elements.removeLast().split(separator: "\n")
                .map { Space(String($0), presents: presents) }
    }

    func solve() -> Int {
        return spaces.filter { $0.canFit() }.count
    }
}
