//
//  FileSystem.swift
//  day-09
//
//  Created by Dragan Cecavac on 09.12.24.
//

class FileSystem {
    var fs = [Int?]()

    var fileStart = [Int:Int]()
    var fileSize = [Int:Int]()

    var freeChunks2 = [Int:[Int]]()
    var freeChunks = [(Int, Int)]()

    var maxIndex = 0

    init(_ data: String) {
        var file = true
        var index = 0

        for char in data {
            let value = Int(String(char))!

            if file {
                fileStart[index] = fs.count
                fileSize[index] = value
            } else {
                freeChunks.append((fs.count, value))
            }

            for _ in 0..<value {
                if file {
                    fs.append(index)
                } else {
                    fs.append(nil)
                }
            }

            if file {
                maxIndex = index
                index += 1
            }
            file = !file
        }
    }

    var checksum: Int {
        var result = 0
        for i in fs.indices {
            if let val = fs[i] {
                result += i * val
            }
        }
        return result
    }

    func squash() {
        var head = 0
        let tailValue = fs.last(where: { $0 != nil })!
        var tail = fs.lastIndex(of: tailValue)!

        while head < tail {
            if fs[head] != nil {
                head += 1
            }
            if fs[tail] == nil {
                tail -= 1
            }

            if fs[head] == nil && fs[tail] != nil {
                fs[head] = fs[tail]
                fs[tail] = nil
            }
        }
    }

    func defragment() {
        for index in (0...maxIndex).reversed() {
            let start = fileStart[index]!
            let size = fileSize[index]!
            var freeLocation: Int? = nil

            for i in freeChunks.indices {
                if freeChunks[i].0 >= start {
                    break
                }

                if freeChunks[i].1 >= size {
                    freeLocation = i
                    break
                }
            }

            if freeLocation != nil {
                let freeStart = freeChunks[freeLocation!].0
                freeChunks[freeLocation!].0 += size
                freeChunks[freeLocation!].1 -= size

                if freeChunks[freeLocation!].1 == 0 {
                    freeChunks.remove(at: freeLocation!)
                }

                for i in (freeStart)..<(freeStart + size) {
                    fs[i] = index
                }

                for i in start..<(start + size) {
                    fs[i] = nil
                }
            }

        }
    }
}
