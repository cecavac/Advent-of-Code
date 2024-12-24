//
//  Swapper.swift
//  day-24
//
//  Created by Dragan Cecavac on 24.12.24.
//

class Swapper {
    var reference: Circuit
    var testValues = [(Int, Int, Int)]()
    var passingTests = Set<Int>()
    var failingTests = Set<Int>()

    init(_ data: String) {
        reference = Circuit(data)
        reference.process()

        var x = 0b110
        var y = 0b011
        for _ in 0...42 {
            testValues.append((x, y, x + y))
            testValues.append((y, y, y + y))
            x = x << 1
            y = y << 1
        }
    }

    func testWith(x: Int, y: Int) -> Int? {
        reference.outputWires = [:]
        reference.overwrite(x: x, y: y)
        reference.orderedProcess()
        return reference.zValue()
    }

    func sortTests() {
        failingTests.removeAll()
        passingTests.removeAll()

        for i in testValues.indices {
            if testWith(x: testValues[i].0, y: testValues[i].1) != testValues[i].2 {
                failingTests.insert(i)
            } else {
                passingTests.insert(i)
            }
        }
    }

    func collectErrors(among: Set<Int>) -> Int {
        return among
            .filter { testWith(x: testValues[$0].0, y: testValues[$0].1) != testValues[$0].2 }
            .count
    }

    func fix() -> String {
        var swapped = [String]()
        sortTests()
        var errors = collectErrors(among: failingTests)
        let sortedGates = Array(reference.gates).sorted { $0 > $1 }

        while errors > 0 {
            for i in 0..<(sortedGates.count - 1) {
                let g1 = sortedGates[i]
                if swapped.contains(g1.out) {
                    continue
                }

                for j in (i + 1)..<sortedGates.count {
                    let g2 = sortedGates[j]
                    if swapped.contains(g1.out) {
                        break
                    }
                    if swapped.contains(g2.out)  {
                        continue
                    }

                    // swap the outputs
                    let tmp = g1.out
                    g1.out = g2.out
                    g2.out = tmp

                    let newErrors = collectErrors(among: failingTests)
                    if newErrors < errors &&
                        !reference.isStuck &&
                        collectErrors(among: passingTests) == 0 {

                        errors = newErrors
                        sortTests()

                        swapped.append(g1.out)
                        swapped.append(g2.out)
                    } else {
                        // swap back the outputs
                        let tmp = g1.out
                        g1.out = g2.out
                        g2.out = tmp
                    }
                }
            }
        }

        return swapped.sorted().joined(separator: ",")
    }
}
