//
//  Firewall.swift
//  Advent13
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Firewall: NSCopying {
    class Layer {
        var position = 0
        var offset = 1
        let size: Int

        init(size: Int) {
            self.size = size
        }

        public func tick() {
            position += offset

            if position == 0 {
                offset = 1
            }

            if position == size - 1 {
                offset = -1
            }
        }
    }

    var layers: [Int:Layer] = [:]
    var finalID = 0

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let elements = line.split(separator: ":")

            let id = Int(elements[0])!
            var sizeString = String(elements[1])
            sizeString = String(sizeString.suffix(sizeString.count - 1))
            let size = Int(sizeString)!

            let layer = Layer(size: size)
            layers[id] = layer

            finalID = max(finalID, id)
        }
    }

    public func getSeverity() -> Int {
        var severity = 0

        for i in 0...finalID {
            if let layer = layers[i] {
                if layer.position == 0 {
                    severity += i * layer.size
                }
            }

            for (_, layer) in layers {
                layer.tick()
            }
        }

        return severity
    }

    public func delay(by ticks: Int) {
        for _ in 0..<ticks {
            for (_, layer) in layers {
                layer.tick()
            }
        }
    }

    public func isSafe(tick: Int) -> Bool {
        for (id, layer) in layers {
            let period = 2 + (layer.size - 2) * 2

            if (tick + id) % period == 0 {
                return false
            }
        }

        return true
    }

    private init(layers: [Int:Layer], finalID: Int) {
        self.finalID = finalID
        for (id, layer) in layers {
            self.layers[id] = layer
        }
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Firewall(layers: layers, finalID: finalID)
        return copy
    }
}
