//
//  Terminal.swift
//  Advent07
//
//  Created by Dragan Cecavac on 07.12.22.
//

import Foundation

class Terminal {
    var fs = [String:Directory]()
    var root: Directory = Directory(name: "/")
    var position = "/"

    init(_ input: String) {
        fs["/"] = root

        let commands = input.split(separator: "$ ")
        for command in commands {
            let lines = command.split(separator: "\n")
            let commandElements = lines[0].split(separator: " ")
            if commandElements[0] == "cd" {
                cd(to: String(commandElements[1]))
            } else if commandElements[0] == "ls" {
                for i in 1..<lines.count {
                    add(item: String(lines[i]))
                }
            } else {
                print("Unsupported command detected \(commandElements[0])")
            }
        }
    }

    func combinePaths(base: String, additional: String) -> String {
        if base == "/" {
            return "/\(additional)"
        } else {
            return "\(base)/\(additional)"
        }
    }

    func cd(to argument: String) {
        if argument == "/" {
            position = "/"
        } else if argument == ".." {
            let subdirs = position.split(separator: "/")
            position = "/"
            for i in 0..<subdirs.count - 1 {
                position = combinePaths(base: position, additional: String(subdirs[i]))
            }
        } else {
            position = combinePaths(base: position, additional: argument)
        }
    }

    func add(item: String) {
        let elements = item.split(separator: " ")
        if elements[0] == "dir" {
            let dir = Directory(name: String(elements[1]))
            if !fs[position]!.contains(dir) {
                fs[position]!.add(dir)
                let fullPath = combinePaths(base: position, additional: String(elements[1]))
                fs[fullPath] = dir
            }
        } else {
            let file = File(name: String(elements[1]), size: Int(String(elements[0]))!)
            fs[position]!.add(file)
        }
    }

    func smallDirSize() -> Int {
        return fs.map { $0.value.size() }
                .filter { $0 <= 100000 }
                .reduce(0, +)
    }

    func deleteDirSize() -> Int {
        let targetSize = Input.MAX_FS_SIZE - Input.UPDATE_SIZE
        let spaceNeeded = root.size() - targetSize

        return fs.map { $0.value.size() }
                .filter { $0 >= spaceNeeded }
                .min()!
    }
}
