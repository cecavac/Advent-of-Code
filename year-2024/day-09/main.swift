//
//  main.swift
//  day-09
//
//  Created by Dragan Cecavac on 09.12.24.
//

import Foundation

let fileSystem1 = FileSystem(Input.Input)
fileSystem1.squash()
print("Result1: \(fileSystem1.checksum)")

let fileSystem2 = FileSystem(Input.Input)
fileSystem2.defragment()
print("Result2: \(fileSystem2.checksum)")
