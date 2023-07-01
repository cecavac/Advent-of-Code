//
//  Scrambler.swift
//  Advent21
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Scrambler {
    internal var password: [Character]

    var result: String {
        return String(password)
    }

    init(do input: String, for pass: String) {
        password = Array(pass)

        let lines = input.split(separator: "\n")
        for line in lines {
            let elements = line.split(separator: " ")
            switch elements[0] {
            case "swap":
                if elements[1] == "position" {
                    let x = Int(elements[2])!
                    let y = Int(elements[5])!

                    swap(x: x, y: y)
                } else if elements[1] == "letter" {
                    let x = elements[2].first!
                    let y = elements[5].first!

                    swap(x: x, y: y)
                } else {
                    print("Error swap option \(elements[1])")
                }
            case "reverse":
                let x = Int(elements[2])!
                let y = Int(elements[4])!

                reverse(x: x, y: y)
            case "rotate":
                if elements[1] == "left" {
                    let x = Int(elements[2])!

                    rotateLeft(by: x)
                } else if elements[1] == "right" {
                    let x = Int(elements[2])!

                    rotateRight(by: x)
                }  else if elements[1] == "based" {
                   let x = elements[6].first!

                   rotate(basedOn: x)
               }else {
                    print("Error swap option \(elements[1])")
                }
            case "move":
                let x = Int(elements[2])!
                let y = Int(elements[5])!

                move(x: x, y: y)
            default:
                print("Error line \(line)")
            }
        }
    }

    internal func move(x: Int, y: Int) {
        let char = password.remove(at: x)
        password.insert(char, at: y)
    }

    internal func swap(x: Int, y: Int) {
        let tmp = password[x]
        password[x] = password[y]
        password[y] = tmp
    }

    internal func swap(x: Character, y: Character) {
        var xIndex = -1
        var yIndex = -1

        for i in 0..<password.count {
            if password[i] == x {
                xIndex = i
            }

            if password[i] == y {
                yIndex = i
            }
        }

        swap(x: xIndex, y: yIndex)
    }

    internal func rotateLeft(by n: Int) {
        for _ in 0..<n {
            let tmp = password.removeFirst()
            password.append(tmp)
        }
    }

    internal func rotateRightCore(by n: Int) {
        for _ in 0..<n {
            let tmp = password.removeLast()
            password.insert(tmp, at: 0)
        }
    }

    internal func rotateRight(by n: Int) {
        rotateRightCore(by: n)
    }

    internal func rotate(basedOn x: Character) {
        var rotations = -1

        for i in 0..<password.count {
            if password[i] == x {
                rotations = i
            }
        }

        if (rotations == -1) {
            print("Bad rotations")
        }

        if rotations >= 4 {
            rotations += 1
        }

        rotations += 1
        rotateRightCore(by: rotations)
    }

    internal func reverse(x: Int, y: Int) {
        var newPassword = Array<Character>()
        var reversedPasswordPart = Array<Character>()

        for i in 0..<x {
            newPassword.append(password[i])
        }

        for i in x...y {
            reversedPasswordPart.append(password[i])
        }

        reversedPasswordPart.reverse()
        for char in reversedPasswordPart {
            newPassword.append(char)
        }

        for i in y + 1..<password.count {
            newPassword.append(password[i])
        }

        password = newPassword
    }
}
