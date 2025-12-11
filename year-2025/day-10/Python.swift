//
//  Python.swift
//  day-10
//
//  Created by Dragan Cecavac on 11.12.25.
//

import Foundation

class Python {
    static func run(_ input: String) -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/local/bin/python3")
        process.arguments = [
            "/Users/dragancecavac/Projects/Advent2025/day-10/day-10/solve.py",
            input
        ]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
            process.waitUntilExit()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return String(data: data, encoding: .utf8)!
                .replacing("\n", with: "")
        } catch {
            fatalError("Failed to run Python: \(error)")
        }
    }
}
