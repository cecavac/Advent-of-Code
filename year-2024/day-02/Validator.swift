//
//  Validator.swift
//  day-02
//
//  Created by Dragan Cecavac on 02.12.24.
//

class Validator {
    var reports: Array<Array<Int>> = []

    init(_ data: String) {
        for line in data.split(separator: "\n") {
            let report = Array(
                line.split(separator: " ").map { Int(String($0))! }
            )
            reports.append(report)
        }
    }

    func isSafe(report: Array<Int>) -> Bool {
        let ascendingReport = report.sorted(by: {$0 > $1})
        let descendingReport = report.sorted()

        if (report != ascendingReport && report != descendingReport) {
            return false
        }

        for i in report.indices {
            if i == 0 {
                continue
            }
            let difference = abs(report[i] - report[i - 1])
            if (difference == 0 || difference > 3) {
                return false
            }
        }

        return true
    }

    func isDampenedSafe(report: Array<Int>) -> Bool {
        if (isSafe(report: report)) {
            return true
        }

        for i in report.indices {
            var reducedReport = report
            reducedReport.remove(at: i)
            if (isSafe(report: reducedReport)) {
                return true
            }
        }

        return false
    }

    func safe() -> Int {
        return reports.filter { isSafe(report: $0) }.count
    }

    func dampenedSafe() -> Int {
        return reports.filter { isDampenedSafe(report: $0) }.count
    }
}
