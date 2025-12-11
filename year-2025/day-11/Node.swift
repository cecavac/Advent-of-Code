//
//  Node.swift
//  day-11
//
//  Created by Dragan Cecavac on 11.12.25.
//

struct Node {
    let from: String
    let to: Array<String>

    init(_ data: String) {
        let elements = data.split(separator: ": ")
        from = String(elements[0])
        to = elements[1].split(separator: " ").map { String($0) }
    }
}
