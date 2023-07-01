//
//  Input.swift
//  Advent23
//
//  Created by Dragan Cecavac on 11.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Input {
    public static let Input1 = """
jio a, +22
inc a
tpl a
tpl a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
jmp +19
tpl a
tpl a
tpl a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
tpl a
jio a, +8
inc b
jie a, +4
tpl a
inc a
jmp +2
hlf a
jmp -7
"""

    public static let Example1 = """
inc a
jio a, +2
tpl a
inc a
"""
}
