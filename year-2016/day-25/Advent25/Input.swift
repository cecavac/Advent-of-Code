//
//  Input.swift
//  Advent25
//
//  Created by Dragan Cecavac on 03.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Input {
    public static let Input1 = """
cpy a d
cpy 9 c
cpy 282 b
inc d
dec b
jnz b -2
dec c
jnz c -5
cpy d a
jnz 0 0
cpy a b
cpy 0 a
cpy 2 c
jnz b 2
jnz 1 6
dec b
dec c
jnz c -4
inc a
jnz 1 -7
cpy 2 b
jnz c 2
jnz 1 4
dec b
dec c
jnz 1 -4
jnz 0 0
out b
jnz a -19
jnz 1 -21
"""
}
