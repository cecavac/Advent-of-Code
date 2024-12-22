//
//  Exchange.swift
//  day-22
//
//  Created by Dragan Cecavac on 22.12.24.
//

class Exchange {
    let numbers: Array<Int>
    var records = [[Int]]()
    var prices = [[Int]]()
    var changes = [[Int]]()
    var sequences = [[String:Int]]()
    var bananas = [String:Int]()

    init(_ data: String) {
        numbers = data.split(separator: "\n")
            .map { Int(String($0))! }

        for i in numbers.indices {
            var recordArray = [Int]()
            var priceArray = [Int]()
            var changeArray = [Int]()
            var value = numbers[i]

            recordArray.append(value)
            var lastDigit = 0
            var currentDigit = value % 10
            priceArray.append(currentDigit)
            changeArray.append(currentDigit - lastDigit)

            for _ in 0..<2000 {
                value = next(old: value)
                recordArray.append(value)

                lastDigit = currentDigit
                currentDigit = value % 10
                priceArray.append(currentDigit)
                changeArray.append(currentDigit - lastDigit)
            }

            records.append(recordArray)
            prices.append(priceArray)
            changes.append(changeArray)
        }
        buildSequences()
    }

    func next(old: Int) -> Int {
        var current = old

        let mul1 = current * 64
        current = mul1 ^ current
        current %= 16777216

        let div = current / 32
        current = div ^ current
        current %= 16777216

        let mul2 = current * 2048
        current = mul2 ^ current
        current %= 16777216

        return current
    }

    func buildSequences() {
        for monkey in changes.indices {
            var sequence = [String:Int]()
            for i in 4..<2000 {
                let hash = "\(changes[monkey][i - 3])"
                + "\(changes[monkey][i - 2])"
                + "\(changes[monkey][i - 1])"
                + "\(changes[monkey][i])"

                if sequence[hash] == nil {
                    sequence[hash] = prices[monkey][i - 3]
                    bananas[hash] = (bananas[hash] ?? 0) + prices[monkey][i - 3]
                }
            }
            sequences.append(sequence)
        }
    }

    func collect() -> Int {
        return records.map { $0.last! }
            .reduce(0, +)
    }

    func bestPrice() -> Int {
        return bananas.values.max()!
    }
}
