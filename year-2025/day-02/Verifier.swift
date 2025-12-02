//
//  Verifier.swift
//  day-02
//
//  Created by Dragan Cecavac on 02.12.25.
//

class Verifier {
    let ids: Array<String>

    init(_ data: String) {
        var ids = Array<String>()

        let lines = data.split(separator: ",")
        for line in lines {
            let range = line.split(separator: "-")
            let start = Int(String(range[0]))!
            let end = Int(String(range[1]))!
            for id in start...end {
                ids.append(String(id))
            }
        }

        self.ids = ids
    }

    func isInvalid(id: String) -> Bool {
        let mid = id.index(id.startIndex, offsetBy: id.count / 2)
        return id[..<mid] == id[mid...]
    }

    func isInvalid2(id: String) -> Bool {
        if id.count == 1 {
            return false
        }

        for prefixLength in 1...id.count / 2 {
            if id.count % prefixLength != 0 {
                continue
            }

            let prefix = String(id.prefix(prefixLength))
            let repeats = id.count / prefixLength
            let repeated = String(repeating: prefix, count: repeats)
            if repeated == id {
                return true
            }
        }

        return false
    }

    func sum() -> Int {
        return ids.filter { isInvalid(id: $0) }
            .map { Int($0)! }
            .reduce(0, +)

    }

    func sum2() -> Int {
        return ids.filter { isInvalid2(id: $0) }
            .map { Int($0)! }
            .reduce(0, +)

    }
}
