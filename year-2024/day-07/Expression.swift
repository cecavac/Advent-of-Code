//
//  Expression.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.24.
//

class Expression {
    let result: Int
    let operands: [Int]

    init(_ data: String) {
        var elements = data.split(separator: " ")
        let resultString = String(elements.remove(at: 0))
            .replacingOccurrences(of: ":", with: "")

        result = Int(resultString)!
        operands = elements.map { Int(String($0))! }
    }

    private func isValid(index: Int, value: Int, extended: Bool) -> Bool {
        let resultAdd = value + operands[index]
        let resultMul = value * operands[index]

        var resultCon = value
        if extended {
            var observedValue = operands[index]
            while observedValue > 0 {
                resultCon *= 10
                observedValue /= 10
            }
            resultCon = resultCon + operands[index]
        }

        if index == operands.count - 1 {
            if resultAdd == result
                || resultMul == result
                || (extended && resultCon == result) {
                return true
            }
            return false
        }

        if resultAdd <= result
            && isValid(index: index + 1, value: resultAdd, extended: extended) {
            return true
        }
        if resultMul <= result
            && isValid(index: index + 1, value: resultMul, extended: extended) {
            return true
        }
        if extended && resultCon <= result && extended
            && isValid(index: index + 1, value: resultCon, extended: extended) {
            return true
        }

        return false
    }

    func isValid(extended: Bool) -> Bool {
        return isValid(index: 1, value: operands[0], extended: extended)
    }
}
