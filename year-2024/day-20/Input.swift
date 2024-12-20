//
//  Input.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.24.
//

class Input {
    public static let Example1 = """
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
"""

    public static let Input = """
#############################################################################################################################################
#...........#...#...#...#.....#...###...#...................#...#.....#.................#.......###...###.......###...###...................#
#.#########.#.#.#.#.#.#.#.###.#.#.###.#.#.#################.#.#.#.###.#.###############.#.#####.###.#.###.#####.###.#.###.#################.#
#.....#.....#.#...#...#.#...#...#.#...#.#.................#...#...#...#.......#.........#.#.....#...#...#.#.....#...#...#.....#.............#
#####.#.#####.#########.###.#####.#.###.#################.#########.#########.#.#########.#.#####.#####.#.#.#####.#####.#####.#.#############
###...#.....#.........#.###.....#.#...#.###.......#.....#...#.......#.......#.#.#.........#.....#.....#.#.#.#...#.....#.###...#.#...#...#...#
###.#######.#########.#.#######.#.###.#.###.#####.#.###.###.#.#######.#####.#.#.#.#############.#####.#.#.#.#.#.#####.#.###.###.#.#.#.#.#.#.#
#...#.......###...#...#.#.......#.....#...#.#.....#...#.....#.......#.....#.#.#.#.....#.........###...#.#.#...#.#...#.#...#...#...#...#...#.#
#.###.#########.#.#.###.#.###############.#.#.#######.#############.#####.#.#.#.#####.#.###########.###.#.#####.#.#.#.###.###.#############.#
#...#...###...#.#.#...#...#.............#.#.#.###...#.........#.....#...#.#.#.#...###.#.###...#...#...#.#.#.....#.#.#.#...#...#...#.........#
###.###.###.#.#.#.###.#####.###########.#.#.#.###.#.#########.#.#####.#.#.#.#.###.###.#.###.#.#.#.###.#.#.#.#####.#.#.#.###.###.#.#.#########
###...#...#.#...#.###.......#...#.....#.#.#.#...#.#...........#...###.#.#.#.#.#...#...#.....#.#.#.....#...#...#...#...#.....#...#...#.......#
#####.###.#.#####.###########.#.#.###.#.#.#.###.#.###############.###.#.#.#.#.#.###.#########.#.#############.#.#############.#######.#####.#
#...#.#...#.#.....#.......#...#.#...#.#.#...#...#.....#.....#...#...#.#.#.#.#.#.###...#...#...#.........#.....#.#.............#...#...#...#.#
#.#.#.#.###.#.#####.#####.#.###.###.#.#.#####.#######.#.###.#.#.###.#.#.#.#.#.#.#####.#.#.#.###########.#.#####.#.#############.#.#.###.#.#.#
#.#...#...#.#.....#.....#.#...#.#...#...#.....#...###...#...#.#.#...#.#.#.#...#.#...#.#.#...#####...#...#.#.....#...............#...#...#...#
#.#######.#.#####.#####.#.###.#.#.#######.#####.#.#######.###.#.#.###.#.#.#####.#.#.#.#.#########.#.#.###.#.#########################.#######
#.....#...#.#.....###...#...#.#.#.......#.#...#.#.....#...#...#.#.#...#.#.#.....#.#...#...#...#...#...#...#...#.......................###...#
#####.#.###.#.#######.#####.#.#.#######.#.#.#.#.#####.#.###.###.#.#.###.#.#.#####.#######.#.#.#.#######.#####.#.#########################.#.#
#.....#...#.#.......#.....#...#.....#...#...#.#...#...#.....#...#...#...#.#.#...#.#.......#.#.#.#.....#.###...#.....#...###...#.....#...#.#.#
#.#######.#.#######.#####.#########.#.#######.###.#.#########.#######.###.#.#.#.#.#.#######.#.#.#.###.#.###.#######.#.#.###.#.#.###.#.#.#.#.#
#.....#...#.#.......#...#.........#...#...#...#...#.#...#...#...#.....###.#.#.#...#...#...#.#.#...#...#...#...#...#...#.....#...#...#.#.#.#.#
#####.#.###.#.#######.#.#########.#####.#.#.###.###.#.#.#.#.###.#.#######.#.#.#######.#.#.#.#.#####.#####.###.#.#.###############.###.#.#.#.#
#.....#.###.#.#...#...#.#...#...#...#...#...###.#...#.#...#...#.#.......#.#.#...#.....#.#...#.#...#.....#.....#.#.#...............###.#.#.#.#
#.#####.###.#.#.#.#.###.#.#.#.#.###.#.#########.#.###.#######.#.#######.#.#.###.#.#####.#####.#.#.#####.#######.#.#.#################.#.#.#.#
#.....#.....#.#.#.#...#...#.#.#.....#.#...###...#.#...#....S#...#.......#.#.#...#.....#.#.....#.#.#.....#.......#.#.......#...........#.#.#.#
#####.#######.#.#.###.#####.#.#######.#.#.###.###.#.###.#########.#######.#.#.#######.#.#.#####.#.#.#####.#######.#######.#.###########.#.#.#
#...#.#.......#.#...#.....#.#.......#.#.#...#.#...#.....#####.....###...#.#...#.......#.#...#...#.#.....#.#.....#.........#.#...........#.#.#
#.#.#.#.#######.###.#####.#.#######.#.#.###.#.#.#############.#######.#.#.#####.#######.###.#.###.#####.#.#.###.###########.#.###########.#.#
#.#.#.#.......#.#...###...#.........#.#.#...#.#.......#######.###...#.#.#.....#.###...#.#...#.#...#...#.#.#.#...#...#...###.#.............#.#
#.#.#.#######.#.#.#####.#############.#.#.###.#######.#######.###.#.#.#.#####.#.###.#.#.#.###.#.###.#.#.#.#.#.###.#.#.#.###.###############.#
#.#...#.......#.#.#...#.............#...#...#.#...#...#######.#...#.#.#.#...#.#...#.#...#...#.#...#.#...#...#.....#.#.#...#.#.......#.....#.#
#.#####.#######.#.#.#.#############.#######.#.#.#.#.#########.#.###.#.#.#.#.#.###.#.#######.#.###.#.###############.#.###.#.#.#####.#.###.#.#
#.#...#...###...#...#.....#.......#.#.......#.#.#...#########.#...#.#.#.#.#.#.#...#.#.......#.#...#...#.............#.#...#.#.....#...###...#
#.#.#.###.###.###########.#.#####.#.#.#######.#.#############.###.#.#.#.#.#.#.#.###.#.#######.#.#####.#.#############.#.###.#####.###########
#...#...#...#...#...#.....#.....#...#...#...#.#.#...#########.#...#...#.#.#.#.#.#...#...#...#.#.#.....#.............#.#.....#.....#...###...#
#######.###.###.#.#.#.#########.#######.#.#.#.#.#.#.#########.#.#######.#.#.#.#.#.#####.#.#.#.#.#.#################.#.#######.#####.#.###.#.#
###...#.#...###...#.#.#...#.....#...#...#.#...#.#.#.#######...#.......#.#.#.#.#.#.....#...#...#.#...#...#.......#...#.#.....#.....#.#.#...#.#
###.#.#.#.#########.#.#.#.#.#####.#.#.###.#####.#.#.#######.#########.#.#.#.#.#.#####.#########.###.#.#.#.#####.#.###.#.###.#####.#.#.#.###.#
#...#...#.....#...#.#.#.#.#.......#.#...#.....#.#.#.#######...#...#...#.#.#.#.#.#.....#.........#...#.#...#...#...#...#...#.......#.#.#.#...#
#.###########.#.#.#.#.#.#.#########.###.#####.#.#.#.#########.#.#.#.###.#.#.#.#.#.#####.#########.###.#####.#.#####.#####.#########.#.#.#.###
#.#.......#...#.#...#...#...#...#...#...#...#.#.#.#.#########.#.#...#...#.#...#.#.....#.#...#...#.###.......#...#...#.....#.........#...#...#
#.#.#####.#.###.###########.#.#.#.###.###.#.#.#.#.#.#########.#.#####.###.#####.#####.#.#.#.#.#.#.#############.#.###.#####.###############.#
#.#.#...#.#.....#...#...#...#.#.#...#.....#...#...#.###.......#...###...#.#.....#...#.#.#.#...#.#.#...#.........#...#.......#.......#.....#.#
#.#.#.#.#.#######.#.#.#.#.###.#.###.###############.###.#########.#####.#.#.#####.#.#.#.#.#####.#.#.#.#.###########.#########.#####.#.###.#.#
#...#.#...#.....#.#...#.#.....#...#.............###.###...#.....#.#...#...#.......#...#...#...#...#.#.#.......#...#.#.........#...#...#...#.#
#####.#####.###.#.#####.#########.#############.###.#####.#.###.#.#.#.#####################.#.#####.#.#######.#.#.#.#.#########.#.#####.###.#
#.....#...#.###...###...#...#...#.............#.#...#E#...#.#...#...#...#...#...###.........#.###...#.........#.#...#...........#.....#...#.#
#.#####.#.#.#########.###.#.#.#.#############.#.#.###.#.###.#.#########.#.#.#.#.###.#########.###.#############.#####################.###.#.#
#.#.....#...#...#...#.#...#...#.............#...#.....#.....#.#.....#...#.#...#...#.........#.#...#.............#...#...#...#...#...#...#...#
#.#.#########.#.#.#.#.#.###################.#################.#.###.#.###.#######.#########.#.#.###.#############.#.#.#.#.#.#.#.#.#.###.#####
#...#.......#.#...#...#...#...#...#...#...#.#.................#.###.#.....#.....#.#.........#...#...#.......#.....#...#...#...#...#...#.....#
#####.#####.#.###########.#.#.#.#.#.#.#.#.#.#.#################.###.#######.###.#.#.#############.###.#####.#.#######################.#####.#
###...#...#...#...........#.#...#...#...#...#.#...#.......#...#...#...#...#...#.#.#...#...#.......###.#...#.#...............#...#...#.......#
###.###.#.#####.###########.#################.#.#.#.#####.#.#.###.###.#.#.###.#.#.###.#.#.#.#########.#.#.#.###############.#.#.#.#.#########
#...#...#.......#...#...#...#.............#...#.#.#...###...#...#.###...#.#...#...###...#...#...#...#.#.#.#...#.....#...#...#.#...#.........#
#.###.###########.#.#.#.#.###.###########.#.###.#.###.#########.#.#######.#.#################.#.#.#.#.#.#.###.#.###.#.#.#.###.#############.#
#.....#...........#.#.#.#...#.#...........#.....#.#...#...#.....#.......#.#.....#...#.........#...#.#...#...#.#...#...#.#.#...#.............#
#######.###########.#.#.###.#.#.#################.#.###.#.#.###########.#.#####.#.#.#.#############.#######.#.###.#####.#.#.###.#############
#...#...#...#.....#...#.....#.#...........###...#...###.#...#...#...#...#...#...#.#.#.#...........#.........#...#.....#...#...#...#.....#...#
#.#.#.###.#.#.###.###########.###########.###.#.#######.#####.#.#.#.#.#####.#.###.#.#.#.#########.#############.#####.#######.###.#.###.#.#.#
#.#...#...#.#...#.....#.....#.#.........#.....#...#...#...#...#...#.#.....#...###.#.#...#.........#...........#.#...#...#...#.#...#.#...#.#.#
#.#####.###.###.#####.#.###.#.#.#######.#########.#.#.###.#.#######.#####.#######.#.#####.#########.#########.#.#.#.###.#.#.#.#.###.#.###.#.#
#.#.....###.....#.....#...#.#.#.....###.........#.#.#...#.#...#.....#...#...#.....#.#.....#.....#...###.......#...#.....#.#.#.#.....#.....#.#
#.#.#############.#######.#.#.#####.###########.#.#.###.#.###.#.#####.#.###.#.#####.#.#####.###.#.#####.#################.#.#.#############.#
#.#.....#.........#...#...#...#.....#.....#...#.#...#...#...#.#.....#.#.....#.....#.#.#...#.###.#.....#...#...#...#...###.#...#...#.........#
#.#####.#.#########.#.#.#######.#####.###.#.#.#.#####.#####.#.#####.#.###########.#.#.#.#.#.###.#####.###.#.#.#.#.#.#.###.#####.#.#.#########
#.#.....#...#...#...#...#.......#...#.#...#.#.#.....#...#...#...###.#.###.....#...#...#.#...#...#...#.#...#.#.#.#.#.#.....#...#.#...#...#...#
#.#.#######.#.#.#.#######.#######.#.#.#.###.#.#####.###.#.#####.###.#.###.###.#.#######.#####.###.#.#.#.###.#.#.#.#.#######.#.#.#####.#.#.#.#
#.#...#.....#.#.#.#.......#...#...#...#.....#.....#.....#.....#.#...#...#.#...#...#.....###...#...#...#.....#.#.#...#.......#.#.#...#.#.#.#.#
#.###.#.#####.#.#.#.#######.#.#.#################.###########.#.#.#####.#.#.#####.#.#######.###.#############.#.#####.#######.#.#.#.#.#.#.#.#
#.#...#.#.....#...#.........#...#...........#...#.........#...#.#.......#.#.#...#.#.#.......#...#...........#...#...#.....###...#.#...#.#.#.#
#.#.###.#.#######################.#########.#.#.#########.#.###.#########.#.#.#.#.#.#.#######.###.#########.#####.#.#####.#######.#####.#.#.#
#.#...#...#...#...#...#...#.....#.......###...#...........#.....#.....#...#.#.#.#...#.....#...#...#.......#.#.....#.....#.........#...#...#.#
#.###.#####.#.#.#.#.#.#.#.#.###.#######.#########################.###.#.###.#.#.#########.#.###.###.#####.#.#.#########.###########.#.#####.#
#.#...#.....#.#.#.#.#.#.#.#...#.......#.........#...#...#.....#...#...#.#...#.#...........#.###.....#...#.#.#.......###.........#...#.......#
#.#.###.#####.#.#.#.#.#.#.###.#######.#########.#.#.#.#.#.###.#.###.###.#.###.#############.#########.#.#.#.#######.###########.#.###########
#...###.....#...#...#...#...#.......#.........#...#...#.#...#.#...#.###.#...#.......#...#...#.....#...#...#.........#...#.....#.#.###...#...#
###########.###############.#######.#########.#########.###.#.###.#.###.###.#######.#.#.#.###.###.#.#################.#.#.###.#.#.###.#.#.#.#
#.....#...#...........#...#.......#.#.......#...#...#...#...#.#...#...#.#...###...#...#...###...#.#...................#.#.#...#...#...#...#.#
#.###.#.#.###########.#.#.#######.#.#.#####.###.#.#.#.###.###.#.#####.#.#.#####.#.#############.#.#####################.#.#.#######.#######.#
#...#.#.#.#...#...###...#.......#.#...#.....#...#.#...###...#.#...#...#.#...#...#...#...#...#...#...............#.....#...#.........#...#...#
###.#.#.#.#.#.#.#.#############.#.#####.#####.###.#########.#.###.#.###.###.#.#####.#.#.#.#.#.#################.#.###.###############.#.#.###
#...#...#...#...#.......#.......#.......#...#.....#.......#.#.#...#.....#...#...#...#.#.#.#.#.#...............#.#...#.....#.....#.....#.#...#
#.#####################.#.###############.#.#######.#####.#.#.#.#########.#####.#.###.#.#.#.#.#.#############.#.###.#####.#.###.#.#####.###.#
#.#.....#...#.......#...#.......#.........#...#...#...#...#.#.#...#.......#...#.#.#...#.#.#.#.#.#.............#...#.....#...###.#...###.....#
#.#.###.#.#.#.#####.#.#########.#.###########.#.#.###.#.###.#.###.#.#######.#.#.#.#.###.#.#.#.#.#.###############.#####.#######.###.#########
#.#.#...#.#...#...#.#.#.......#...#...........#.#.....#.#...#.....#.#...#...#...#.#...#.#.#.#...#...............#.......#.....#...#.........#
#.#.#.###.#####.#.#.#.#.#####.#####.###########.#######.#.#########.#.#.#.#######.###.#.#.#.###################.#########.###.###.#########.#
#...#.....#.....#...#.#...#...#...#.........#...#...#...#.........#.#.#.#.#...#...#...#...#.....#...#...#.....#...........#...###...#.......#
###########.#########.###.#.###.#.#########.#.###.#.#.###########.#.#.#.#.#.#.#.###.###########.#.#.#.#.#.###.#############.#######.#.#######
#...###...#.........#.#...#.....#...........#.#...#...###.......#.#...#.#...#.#...#...#.........#.#...#...###...........#...#...###...#...###
#.#.###.#.#########.#.#.#####################.#.#########.#####.#.#####.#####.###.###.#.#########.#####################.#.###.#.#######.#.###
#.#.....#.....#...#.#.#.....#.......#.......#.#.###.....#...#...#.....#...#...#...###.#.#.......#...#.................#...#...#.#.......#...#
#.###########.#.#.#.#.#####.#.#####.#.#####.#.#.###.###.###.#.#######.###.#.###.#####.#.#.#####.###.#.###############.#####.###.#.#########.#
#...#...#...#...#...#...###...###...#.#.....#.#...#...#.....#.#...###.#...#...#.#.....#.#.#.....###...###.............#...#.#...#...#.......#
###.#.#.#.#.###########.#########.###.#.#####.###.###.#######.#.#.###.#.#####.#.#.#####.#.#.#############.#############.#.#.#.#####.#.#######
#...#.#...#.....#.....#...###...#.....#...###...#...#.......#.#.#...#.#.#...#.#.#.....#...#.#...#...#...#...#...........#.#.#.#.....#.......#
#.###.#########.#.###.###.###.#.#########.#####.###.#######.#.#.###.#.#.#.#.#.#.#####.#####.#.#.#.#.#.#.###.#.###########.#.#.#.###########.#
#...#.#.....#...#.###...#.....#.........#.#...#.#...###...#.#.#...#.#.#.#.#.#.#...#...#.....#.#.#.#.#.#.....#.#.......#...#.#...#.....#...#.#
###.#.#.###.#.###.#####.###############.#.#.#.#.#.#####.#.#.#.###.#.#.#.#.#.#.###.#.###.#####.#.#.#.#.#######.#.#####.#.###.#####.###.#.#.#.#
#...#.#...#...#...#...#...#...#.......#...#.#.#.#.....#.#.#.#.....#...#.#.#.#.#...#...#.....#.#...#.#.........#.....#...###.#.....###...#...#
#.###.###.#####.###.#.###.#.#.#.#####.#####.#.#.#####.#.#.#.###########.#.#.#.#.#####.#####.#.#####.###############.#######.#.###############
#.#...#...#...#.#...#.....#.#.#.#.....#...#.#.#.#.....#.#.#.........#...#.#.#.#.#...#...#...#...#...#...#.......#...###.....#...............#
#.#.###.###.#.#.#.#########.#.#.#.#####.#.#.#.#.#.#####.#.#########.#.###.#.#.#.#.#.###.#.#####.#.###.#.#.#####.#.#####.###################.#
#.#.#...#...#...#.....#...#.#.#.#.#...#.#.#.#.#.#.#...#.#.#...#...#.#...#.#.#.#.#.#...#.#...#...#...#.#.#.....#...#.....#.....#.............#
#.#.#.###.###########.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.###.#.#.#.#.#.###.#.###.#.#####.#.#.#####.#####.#####.###.#.#############
#...#.....###.........#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#...#.#.#.#...#.#.#...#...#...#.#...#.....#...#...#...###...#...#...#.#.#...#...#...#
#############.#########.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#.#####.#.#.###.#.#.#########.###.#.#######.#######.#.#####.###.#.###.#.#.#.#.#.#.#.#.#
#.............#...#...#.#.#.#...#.#.#.#.#.#.#...#...#.#.....#.#.#.#...#.#.........#.#...#.#...#...###.....#.......#...#.....#.#...#...#...#.#
#.#############.#.#.#.#.#.#.#####.#.#.#.#.#.#########.#####.#.#.#.#.###.#########.#.#.###.#.#.#.#####.#############.#########.#############.#
#...#...#.....#.#...#.#.#...#.....#.#...#.#.........#...#...#.#.#.#.###...#...#...#.#.#...#.#...#...#.....#.......#.........#.#...#.......#.#
###.#.#.#.###.#.#####.#.#####.#####.#####.#########.###.#.###.#.#.#.#####.#.#.#.###.#.#.###.#####.#.#####.#.#####.#########.#.#.#.#.#####.#.#
#...#.#...#...#.#.....#.....#.....#...#...#...#.....#...#.#...#.#.#.....#.#.#.#...#.#.#...#.......#.#.....#.....#.#...#.....#...#.#...#...#.#
#.###.#####.###.#.#########.#####.###.#.###.#.#.#####.###.#.###.#.#####.#.#.#.###.#.#.###.#########.#.#########.#.#.#.#.#########.###.#.###.#
#...#.#...#...#.#.....#...#...###.#...#.....#.#.....#...#.#...#.#.....#.#...#...#.#.#.###...#...#...#.#...#.....#.#.#.#.........#.#...#...#.#
###.#.#.#.###.#.#####.#.#.###.###.#.#########.#####.###.#.###.#.#####.#.#######.#.#.#.#####.#.#.#.###.#.#.#.#####.#.#.#########.#.#.#####.#.#
#...#.#.#.....#.###...#.#...#.#...#.#.....#...#...#.###.#.#...#.....#.#.#...###.#.#.#.#.....#.#.#...#.#.#.#.#...#...#.#...#.....#.#...#...#.#
#.###.#.#######.###.###.###.#.#.###.#.###.#.###.#.#.###.#.#.#######.#.#.#.#.###.#.#.#.#.#####.#.###.#.#.#.#.#.#.#####.#.#.#.#####.###.#.###.#
#.#...#...#...#...#...#...#...#.....#...#...#...#.#.#...#.#.#...#...#.#.#.#.....#.#.#.#.#.....#.#...#.#.#.#...#.#.....#.#.#.....#.#...#.#...#
#.#.#####.#.#.###.###.###.#############.#####.###.#.#.###.#.#.#.#.###.#.#.#######.#.#.#.#.#####.#.###.#.#.#####.#.#####.#.#####.#.#.###.#.###
#...#...#...#...#...#.....#...###...###.#...#.###...#...#.#.#.#.#...#.#.#...#...#.#.#.#.#...#...#.###...#.#.....#.....#.#...#...#.#...#.#.###
#####.#.#######.###.#######.#.###.#.###.#.#.#.#########.#.#.#.#.###.#.#.###.#.#.#.#.#.#.###.#.###.#######.#.#########.#.###.#.###.###.#.#.###
#.....#.........#...###.....#.....#.....#.#.#...#.......#.#.#.#.#...#.#.#...#.#...#.#.#.....#.#...#.......#.........#.#.#...#...#...#.#.#...#
#.###############.#####.#################.#.###.#.#######.#.#.#.#.###.#.#.###.#####.#.#######.#.###.###############.#.#.#.#####.###.#.#.###.#
#.............#...#.....#...#...#...#...#.#...#.#...#...#.#...#.#...#.#.#...#.#.....#.....#...#...#.#.....#.....#...#.#.#.#...#...#...#.....#
#############.#.###.#####.#.#.#.#.#.#.#.#.###.#.###.#.#.#.#####.###.#.#.###.#.#.#########.#.#####.#.#.###.#.###.#.###.#.#.#.#.###.###########
#.............#.###.#...#.#.#.#.#.#.#.#.#...#.#...#...#.#...#...#...#.#.###...#...#...#...#.#...#.#...#...#...#.#...#...#.#.#...#...###...###
#.#############.###.#.#.#.#.#.#.#.#.#.#.###.#.###.#####.###.#.###.###.#.#########.#.#.#.###.#.#.#.#####.#####.#.###.#####.#.###.###.###.#.###
#.......#.....#.#...#.#...#.#.#.#.#.#.#.#...#.#...###...#...#...#...#.#.#.........#.#.#...#...#...#.....#...#.#...#...###.#.###...#.....#...#
#######.#.###.#.#.###.#####.#.#.#.#.#.#.#.###.#.#####.###.#####.###.#.#.#.#########.#.###.#########.#####.#.#.###.###.###.#.#####.#########.#
#.....#...#...#.#...#...###.#.#...#.#.#.#.#...#.....#...#...###.#...#...#...#.......#...#...#.......#...#.#...###.....#...#.....#.#...#...#.#
#.###.#####.###.###.###.###.#.#####.#.#.#.#.#######.###.###.###.#.#########.#.#########.###.#.#######.#.#.#############.#######.#.#.#.#.#.#.#
#...#.#...#...#.#...#...#...#...#...#.#.#.#.#...#...#...#...#...#.........#.#.#.........#...#.....#...#...#...#...#.....#...#...#.#.#.#.#.#.#
###.#.#.#.###.#.#.###.###.#####.#.###.#.#.#.#.#.#.###.###.###.###########.#.#.#.#########.#######.#.#######.#.#.#.#.#####.#.#.###.#.#.#.#.#.#
#...#...#.....#.#.....###...#...#.#...#.#.#.#.#...###...#...#.#...#...#...#...#...#.....#...#.....#.........#...#.#...#...#.#.###.#.#.#.#.#.#
#.#############.###########.#.###.#.###.#.#.#.#########.###.#.#.#.#.#.#.#########.#.###.###.#.###################.###.#.###.#.###.#.#.#.#.#.#
#.#...#.....#...#...........#.#...#...#.#.#.#.#.........#...#.#.#.#.#.#.........#.#.#...#...#.#.....#...#...#...#.#...#...#.#...#.#.#.#.#.#.#
#.#.#.#.###.#.###.###########.#.#####.#.#.#.#.#.#########.###.#.#.#.#.#########.#.#.#.###.###.#.###.#.#.#.#.#.#.#.#.#####.#.###.#.#.#.#.#.#.#
#...#...###...###.............#.......#...#...#...........###...#...#...........#...#.....###...###...#...#...#...#.......#.....#...#...#...#
#############################################################################################################################################
"""
}