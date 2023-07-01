//
//  CommunicationBox.swift
//  Advent18
//
//  Created by Dragan Cecavac on 12.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class CommunicationBox {
    var instructions: [String] = []
    var ip = 0
    var registers: [String:Int] = [:]
    var sent = 0
    var done = false
    var locked = false

    let sendQueue: FakeBlockingQueue
    let receiveQueue: FakeBlockingQueue

    init(_ input: String, send: FakeBlockingQueue, receive: FakeBlockingQueue, id: Int) {
        let lines = input.split(separator: "\n")
        for line in lines {
            instructions.append(String(line))
        }

        sendQueue = send
        receiveQueue = receive

        registers["p"] = id
    }

    private func getVal(_ input: String) -> Int {
        if let value = Int(input) {
            return value
        } else if let value = registers[input] {
            return value
        } else {
            return 0
        }
    }

    private func setVal(register: String, value: Int) {
        registers[register] = value
    }

    public func tick() {
        done = ip < 0 || ip >= instructions.count
        if done {
            return
        }

        let elements = instructions[ip].split(separator: " ")
        let value = getVal(String(elements[1]))

        switch elements[0] {
        case "snd":
            sent += 1
            sendQueue.messages.append(value)

            ip += 1
        case "set":
            let value2 = getVal(String(elements[2]))
            setVal(register: String(elements[1]), value: value2)

            ip += 1
        case "add":
            let value2 = getVal(String(elements[2]))
            setVal(register: String(elements[1]), value: value + value2)

            ip += 1
        case "mul":
            let value2 = getVal(String(elements[2]))
            setVal(register: String(elements[1]), value: value * value2)

            ip += 1
        case "mod":
            let value2 = getVal(String(elements[2]))
            setVal(register: String(elements[1]), value: value % value2)

            ip += 1
        case "rcv":
            if receiveQueue.messages.count > 0 {
                setVal(register: String(elements[1]), value: receiveQueue.messages.removeFirst())

                locked = false
                ip += 1
            } else {
                locked = true
            }
        case "jgz":
            if value > 0 {
                let value2 = getVal(String(elements[2]))
                ip += value2
            } else {
                ip += 1
            }
        default:
            print("Bad instruction opcode: \(elements[0])")
        }
    }
}
