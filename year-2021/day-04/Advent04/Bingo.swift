//
//  Bingo.swift
//  Advent04
//
//  Created by Dragan Cecavac on 04.12.21.
//

import Foundation

class Bingo {
    var numbers = [Int]()
    var boards = [Board]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        let numbersData = lines[0].split(separator: ",")
        for numberData in numbersData {
            numbers.append(Int(String(numberData))!)
        }

        var i = 1
        while i < lines.count {
            var boardInput = ""
            for _ in 0..<5 {
                boardInput += lines[i] + "\n"
                i += 1
            }
            boards.append(Board(boardInput))
        }
    }

    func play() -> Int {
        while numbers.count > 0 {
            let number = numbers.removeFirst()
            for board in boards {
                board.draw(number)
            }

            if let winner = boards.filter({ $0.won }).first {
                return winner.score
            }
        }

        return 0
    }

    func playToTheEnd() -> Int {
        while boards.count != 1 {
            _ = play()
            boards = boards.filter { !$0.won }
        }

        return play()
    }
}
