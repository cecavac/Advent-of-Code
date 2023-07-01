//
//  QuantumDiracDice.swift
//  Advent21
//
//  Created by Dragan Cecavac on 21.12.21.
//

import Foundation

class QuantumDiracDice {
    private static let diceSides = 3
    private static let goal = 21
    var round = 1

    var scores1 = Array(repeating: Array<UInt64>(repeating: 0, count: QuantumDiracDice.goal), count: DiracDice.fields)
    var scores2 = Array(repeating: Array<UInt64>(repeating: 0, count: QuantumDiracDice.goal), count: DiracDice.fields)

    var player1Wins = Array<UInt64>()
    var player2Wins = Array<UInt64>()
    var player1Remaining = Array<UInt64>()
    var player2Remaining = Array<UInt64>()

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        let elements1 = lines[0].split(separator: " ")
        scores1[Int(String(elements1.last!))! - 1][0] = 1

        let elements2 = lines[1].split(separator: " ")
        scores2[Int(String(elements2.last!))! - 1][0] = 1

        player1Wins.append(0)
        player1Remaining.append(0)
        player2Wins.append(0)
        player2Remaining.append(0)
    }

    func tick() {
        let reoundIndex = (round - 1) / 2
        var newScores = Array(repeating: Array<UInt64>(repeating: 0, count: QuantumDiracDice.goal), count: DiracDice.fields)

        for die1 in 1...QuantumDiracDice.diceSides {
            for die2 in 1...QuantumDiracDice.diceSides {
                for die3 in 1...QuantumDiracDice.diceSides {
                    for position in 0..<DiracDice.fields {
                        let die = die1 + die2 + die3
                        let newPosition = (position + die) % DiracDice.fields
                        let scoreIncrement = newPosition + 1

                        for score in 0..<QuantumDiracDice.goal {
                            if round % 2 == 1 {
                                if score + scoreIncrement >= QuantumDiracDice.goal {
                                    player1Wins[reoundIndex] += scores1[position][score]
                                } else {
                                    newScores[newPosition][score + scoreIncrement] += scores1[position][score]
                                }
                            } else {
                                if score + scoreIncrement >= QuantumDiracDice.goal {
                                    player2Wins[reoundIndex] += scores2[position][score]
                                } else {
                                    newScores[newPosition][score + scoreIncrement] += scores2[position][score]
                                }
                            }
                        }
                    }
                }
            }
        }

        if round % 2 == 1 {
            scores1 = newScores

            for positionScores in scores1 {
                for score in positionScores {
                    player1Remaining[reoundIndex] += score
                }
            }

            player1Wins.append(0)
            player1Remaining.append(0)
        } else {
            scores2 = newScores
            for positionScores in scores2 {
                for score in positionScores {
                    player2Remaining[reoundIndex] += score
                }
            }

            player2Wins.append(0)
            player2Remaining.append(0)
        }

        round += 1
    }

    func play() -> UInt64 {
        while round < 3
                || player1Remaining[(round - 2) / 2] != 0
                || player2Remaining[(round - 2) / 2] != 0 {
            tick()
        }

        var player1TotalWins: UInt64 = 0
        for i in 1..<player1Remaining.count {
            player1TotalWins += player1Wins[i] * player2Remaining[i - 1]
        }

        var player2TotalWins: UInt64 = 0
        for i in 1..<player2Remaining.count {
            player2TotalWins += player2Wins[i] * player1Remaining[i]
        }

        return max(player1TotalWins, player2TotalWins)
    }
}
