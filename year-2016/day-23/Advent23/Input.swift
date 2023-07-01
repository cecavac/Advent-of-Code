//
//  Input.swift
//  Advent23
//
//  Created by Dragan Cecavac on 31.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Input {
    public static let Input1 = """
cpy a b
dec b
cpy a d
cpy 0 a
cpy b c
inc a
dec c
jnz c -2
dec d
jnz d -5
dec b
cpy b c
cpy c d
dec d
inc c
jnz d -2
tgl c
cpy -16 c
jnz 1 c
cpy 98 c
jnz 86 d
inc a
inc d
jnz d -2
inc c
jnz c -5
"""

public static let Input2 = """
cpy a b
dec b
cpy a d
cpy 0 a
cpy b c
mul c d
dec b
cpy b c
cpy c d
dec d
inc c
jnz d -2
tgl c
cpy -12 c
jnz 1 c
cpy 98 c
jnz 86 d
inc a
inc d
jnz d -2
inc c
jnz c -5
"""
}
