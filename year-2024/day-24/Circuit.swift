//
//  Circuit.swift
//  day-24
//
//  Created by Dragan Cecavac on 24.12.24.
//

class Circuit {
    var gates = Set<Gate>()
    var orderedGates = [Gate]()
    var inputWires = [String:Bool]()
    var outputWires = [String:Bool]()
    var zWires = [String]()
    var convertedIndexes = [String]()

    var expressions = [String:String]()
    var isStuck = false

    init(_ data: String) {
        if data != "" {
            let sections = data.split(separator: "\n\n")
            for line in sections[0].split(separator: "\n") {
                let elements = line.split(separator: ": ")
                let id = String(elements[0])
                let value = String(elements[1]) == "1"
                inputWires[id] = value
            }
            for line in sections[1].split(separator: "\n") {
                gates.insert(Gate(String(line)))
            }
        }

        orderedGates = Array(gates)

        for i in 0...45 {
            var value = ""
            if i < 10 {
                value += "0"
            }
            value += "\(i)"

            convertedIndexes.append(value)
            zWires.append("z" + value)
        }
        zWires = zWires.reversed()
    }

    func process() {
        var unvisitedGates = gates

        while unvisitedGates.count > 0 {
            for gate in unvisitedGates {
                var left: Bool? = nil
                if let value = inputWires[gate.left] {
                    left = value
                } else if let value = outputWires[gate.left] {
                    left = value
                }

                var right: Bool? = nil
                if let value = inputWires[gate.right] {
                    right = value
                } else if let value = outputWires[gate.right] {
                    right = value
                }

                if left != nil && right != nil {
                    outputWires[gate.out] = gate.result(left: left!, right: right!)
                    unvisitedGates.remove(gate)
                    orderedGates.append(gate)
                }
            }
        }
    }

    func orderedProcess() {
        var unvisitedGates = gates

        isStuck = false
        while unvisitedGates.count > 0 && !isStuck {
            isStuck = true
            for gate in orderedGates {
                if !unvisitedGates.contains(gate) {
                    continue
                }

                var left: Bool? = nil
                if let value = inputWires[gate.left] {
                    left = value
                } else if let value = outputWires[gate.left] {
                    left = value
                }

                var right: Bool? = nil
                if let value = inputWires[gate.right] {
                    right = value
                } else if let value = outputWires[gate.right] {
                    right = value
                }

                if left != nil && right != nil {
                    outputWires[gate.out] = gate.result(left: left!, right: right!)
                    unvisitedGates.remove(gate)
                    isStuck = false
                }
            }
        }
    }

    func overwrite(x: Int, y: Int) {
        var currentX = x
        var currentY = y
        for i in 0...44 {
            let xWire = "x" + convertedIndexes[i]
            let yWire = "y" + convertedIndexes[i]

            inputWires[xWire] = currentX % 2 == 1
            inputWires[yWire] = currentY % 2 == 1

            currentX /= 2
            currentY /= 2
        }
    }

    func zValue() -> Int? {
        var result = 0

        for zWire in zWires {
            result *= 2
            if let value = outputWires[zWire] {
                if value {
                    result += 1
                }
            } else {
                return nil
            }
        }

        return result
    }
}
