//
//  ALU.swift
//  Advent24
//
//  Created by Dragan Cecavac on 24.12.21.
//

import Foundation

class ALU {
    var cache = [[(Int64, Int64, Int64)]]()
    var digits = [Int64]()

    func digest(number: Int64) {
        digits.removeAll()

        var localNumber = number
        while localNumber > 0 {
            digits.append(localNumber % 10)
            localNumber = localNumber / 10
        }
    }

    func process() {
        var encounteredZs = Set<Int64>()
        var targetZs = Set<Int64>()
        targetZs.insert(0)

        for i in (1...14).reversed() {
            var data = [(Int64, Int64, Int64)]()
            var bottomLimit: Int64
            var topLimit: Int64

            // Empirical optimization
            if i == 5 || i == 7 || i == 9 {
                bottomLimit = 200000
                topLimit = 260000
            } else if i == 6 || i == 8  {
                bottomLimit = 6000000
                topLimit = 6600000
            } else {
                bottomLimit = 0
                topLimit = 10000
            }

            for z: Int64 in bottomLimit...topLimit {
                for w: Int64 in 1...9 {
                    digits.append(w)
                    let resultZ = emulate(startZ: Int64(z), section: i)
                    if targetZs.contains(resultZ) {
                        encounteredZs.insert(z)
                        data.append((z, w, resultZ))
                    }
                }
            }

            cache.append(data)

            targetZs = encounteredZs
            encounteredZs.removeAll()
        }

        cache = cache.reversed()
    }

    func result(max: Bool) -> Int64 {
        var lookFor: Int64 = 0
        var result: Int64 = 0

        for data in cache {
            var nexLookFor: Int64 = 0
            var currentDigit: Int64

            if max {
                currentDigit = 0
            } else {
                currentDigit = 10
            }

            for element in data {
                if element.0 == lookFor {
                    if max {
                        if element.1 > currentDigit {
                            currentDigit = element.1
                            nexLookFor = element.2
                        }
                    } else {
                        if element.1 < currentDigit {
                            currentDigit = element.1
                            nexLookFor = element.2
                        }
                    }
                }
            }

            result *= 10
            result += currentDigit
            lookFor = nexLookFor
        }

        return result
    }


    func eql(_ a: Int64, _ b: Int64) -> Int64 {
        if a == b {
            return 1
        } else {
            return 0
        }
    }

    func emulate1(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ

        w = digits.removeLast()
        z += w
        z += 5

        return z
    }

    func emulate2(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ

        w = digits.removeLast()
        z *= 26
        z += w
        z += 5

        return z
    }

    func emulate3(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ

        w = digits.removeLast()
        z *= 26
        z += w
        z += 1

        return z
    }

    func emulate4(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ

        w = digits.removeLast()
        z *= 26
        z += w
        z += 15

        return z
    }

    func emulate5(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 10
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 2
        y *= x
        z += y

        return z
    }

    func emulate6(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -1
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 2
        y *= x
        z += y

        return z
    }

    func emulate7(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 14
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 5
        y *= x
        z += y

        return z
    }

    func emulate8(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -8
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 8
        y *= x
        z += y

        return z
    }

    func emulate9(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -7
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 14
        y *= x
        z += y

        return z
    }

    func emulate10(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -8
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 12
        y *= x
        z += y

        return z
    }

    func emulate11(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 11
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 7
        y *= x
        z += y

        return z
    }

    func emulate12(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -2
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 14
        y *= x
        z += y

        return z
    }

    func emulate13(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -2
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 13
        y *= x
        z += y

        return z
    }

    func emulate14(startZ: Int64) -> Int64 {
        var w: Int64 = 0
        var z: Int64 = startZ
        var x: Int64 = 0
        var y: Int64 = 0

        w = digits.removeLast()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -13
        x = eql(x, w)
        x = eql(x, 0)
        y = 25
        y *= x
        y += 1
        z *= y
        y = w + 6
        y *= x
        z += y

        return z
    }

    func emulate(startZ: Int64, section: Int) -> Int64 {
        switch section {
        case 1:
            return emulate1(startZ: startZ)
        case 2:
            return emulate2(startZ: startZ)
        case 3:
            return emulate3(startZ: startZ)
        case 4:
            return emulate4(startZ: startZ)
        case 5:
            return emulate5(startZ: startZ)
        case 6:
            return emulate6(startZ: startZ)
        case 7:
            return emulate7(startZ: startZ)
        case 8:
            return emulate8(startZ: startZ)
        case 9:
            return emulate9(startZ: startZ)
        case 10:
            return emulate10(startZ: startZ)
        case 11:
            return emulate11(startZ: startZ)
        case 12:
            return emulate12(startZ: startZ)
        case 13:
            return emulate13(startZ: startZ)
        case 14:
            return emulate14(startZ: startZ)
        default:
            print("Error, invalid section")
            return -1
        }
    }

    func emulate() -> Int64 {
        var z: Int64 = 0

        for i in 1...14 {
            z = emulate(startZ: z, section: i)
        }

        return z
    }
}
