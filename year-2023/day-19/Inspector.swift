//
//  Inspector.swift
//  day-19
//
//  Created by Dragan Cecavac on 19.12.23.
//

import Foundation

class Inspector {
    var workflows = [String:Workflow]()
    var items = [Item]()
    let start = "in"

    init(_ input: String) {
        let sections = input.split(separator: "\n\n")

        for line in sections[0].split(separator: "\n") {
            let workflow = Workflow(String(line))
            workflows[workflow.name] = workflow
        }

        for line in sections[1].split(separator: "\n") {
            let item = Item(String(line))
            items.append(item)
        }
    }

    func inspect(item: Item) -> Int {
        var state = start

        while state != "A" && state != "R" {
            let workflow = workflows[state]!
            state = workflow.check(item: item)!
        }

        if state == "A" {
            return item.sum()
        } else {
            return 0
        }
    }

    func sum() -> Int {
        return items.map { inspect(item: $0) }.reduce(0, +)
    }

    var paths = Set<[String]>()

    func explore(from: String, path: [String]) {
        for destination in workflows[from]!.destinations() {
            var newPath = path
            newPath.append(destination)
            if destination == "A" {
                paths.insert(newPath)
            } else if destination != "R"  {
                explore(from: destination, path: newPath)
            }
        }
    }

    func collect(path: [String]) -> [Collection] {
        var collections = [Collection]()
        collections.append(Collection())

        for i in 0..<path.count {
            if path[i] == "A" {
                break
            }
            let workflow = workflows[path[i]]!
            var newCollections = [Collection]()

            for collection in collections {
                var currentCollection = collection
                for rule in workflow.rules {
                    if rule.last == path[i + 1] {
                        var newCollection = currentCollection
                        if rule.gt {
                            newCollection.remove(section: (0, rule.value!), type: rule.first!)
                            newCollections.append(newCollection)
                        } else if rule.lt {
                            newCollection.remove(section: (rule.value!, 4000), type: rule.first!)
                            newCollections.append(newCollection)
                        } else {
                            newCollections.append(newCollection)
                        }
                    }

                    if rule.gt {
                        currentCollection.remove(section: (rule.value! + 1, 4000), type: rule.first!)
                    } else if rule.lt {
                        currentCollection.remove(section: (0, rule.value! - 1), type: rule.first!)
                    }
                }
            }

            collections = newCollections
        }

        return collections
    }

    func possibilities() -> Int {
        explore(from: start, path: [start])

        var collections = [Collection]()
        for path in paths {
            for newCollection in collect(path: path) {
                collections.append(newCollection)
            }
        }

        return collections.map { $0.total() }.reduce(0, +)
    }
}
