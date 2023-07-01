//
//  Environment.swift
//  Advent11
//
//  Created by Dragan Cecavac on 25.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct Environment {
    struct Item {
        let name: String
        let isGenerator: Bool
    }

    func generators(at level: Int) -> [Item] {
        var generatorItems: [Item] = []

        for item in items[level] {
            if item.isGenerator {
                generatorItems.append(item)
            }
        }

        return generatorItems
    }

    func microcontrollers(at level: Int) -> [Item] {
        var microcontrollerItems: [Item] = []

        for item in items[level] {
            if !item.isGenerator {
                microcontrollerItems.append(item)
            }
        }

        return microcontrollerItems
    }

    var items: [[Item]]
    var elevator = 0

    init(_ input: String) {
        items = []

        let lines = input.split(separator: "\n")
        for line in lines {
            var localItems: [Item] = []
            let elements = line.split(separator: " ")

            for i in 0..<elements.count {
                if elements[i] == "a" {
                    if elements[i + 2].starts(with: "g") {
                        let name = String(elements[i + 1])
                        let item = Item(name: name, isGenerator: true)
                        localItems.append(item)
                    } else {
                        let nameElements = elements[i + 1].split(separator: "-")
                        let name = String(nameElements[0])
                        let item = Item(name: name, isGenerator: false)
                        localItems.append(item)
                    }
                }
            }

            items.append(localItems)
        }
    }

    func isValid() -> Bool {
        for i in 0..<items.count {
            for microcontroller in microcontrollers(at: i) {
                if generators(at: i).count == 0 {
                    continue
                } else {
                    var matchingGeneratorExists = false

                    for generator in generators(at: i) {
                        if generator.name == microcontroller.name {
                            matchingGeneratorExists = true
                            break
                        }
                    }

                    if matchingGeneratorExists == false {
                        return false
                    }
                }
            }
        }

        return true
    }

    func isDone() -> Bool {
        var done = true

        for i in 0..<items.count - 1 {
            done = done && items[i].count == 0
        }

        return done
    }

    var possibilities: [Environment] {
        var possibilities: [Environment] = []

        for i in 0..<items[elevator].count - 1 {
            for j in i + 1..<items[elevator].count {
                var copy1 = self
                let element1 = copy1.items[elevator].remove(at: j)
                let element2 = copy1.items[elevator].remove(at: i)

                if elevator < (copy1.items.count - 1) {
                    copy1.items[elevator + 1].append(element1)
                    copy1.items[elevator + 1].append(element2)
                    copy1.elevator = elevator + 1

                    if copy1.isValid() {
                            possibilities.append(copy1)
                    }
                }
            }
        }

        for i in 0..<items[elevator].count {
            var copy1 = self
            let element = copy1.items[elevator].remove(at: i)
            var copy2 = copy1

            if elevator < (copy1.items.count - 1) {
                copy1.items[elevator + 1].append(element)
                copy1.elevator = elevator + 1

                if copy1.isValid() {
                    possibilities.append(copy1)
                }
            }

            if elevator > 0 {
                copy2.items[elevator - 1].append(element)
                copy2.elevator = elevator - 1

                var emptyBelow = true
                for i in 0..<elevator {
                    emptyBelow = emptyBelow && items[i].count == 0
                }

                if copy2.isValid() && !emptyBelow {
                    possibilities.append(copy2)
                }
            }
        }

        possibilities.sort { $0.score > $1.score }

        return possibilities
    }

    mutating func hashVal() -> String {
        var hash = "\(elevator)"
        var id = 0
        var map: [String:Int] = [:]

        for i in 0..<items.count {
            hash += "#\(i)#"
            
            items[i].sort { $0.name < $1.name }

            for item in items[i] {
                var itemId: Int
                if let cachedId = map[item.name] {
                    itemId = cachedId
                } else {
                    map[item.name] = id
                    itemId = id

                    id += 1
                }

                hash += "_\(itemId)_\(item.isGenerator)_"
            }
        }

        return hash
    }

    var score: Int {
        var result = 1000000

        for i in 0..<items.count {
            for item in items[i] {
                if item.isGenerator {
                    result -= 400 * (4 - i)

                    for item2 in items[i] {
                        if !item2.isGenerator && item.name == item2.name {
                            result += 200 * (i + 1)
                        }
                    }
                } else {
                    result -= 900 * (4 - i)
                }
            }
        }

        return result
    }
}
