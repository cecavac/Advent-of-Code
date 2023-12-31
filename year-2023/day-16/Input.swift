//
//  Input.swift
//  day-16
//
//  Created by Dragan Cecavac on 16.12.23.
//

import Foundation

class Input {
    public static let Input1 = """
\\.........|......./...|........................................................|............|-...\\...-/.......
.....................\\.......\\........./...|...............|...\\................................-...|.......\\.
.......................................-....-./............/.......-.............\\..|.......|......//.........
...../..../.....\\.........-.........-./..-.......\\./..\\.............-.....\\..........|-..................|....
...........\\..\\...............-.............|.......-.\\......\\...\\..........\\.......-.....|..................\\
................|.........|........|............--........./\\....|-.....................................-.....
........./...........\\................../...................\\././........./...-...-.\\.-.........-.............
......|.....|............-............./...|...................-...|........./............/......./...........
......./........../..|.....-...........\\|.................................................\\.........|..../....
........................|..................|.......|.................-..\\...........-/.\\.................\\.|..
.......|...|./....................................-...\\........\\.......|............................|...|.....
\\..-................................\\.......\\........../....|.....................|........\\../.........../..\\
....-|...............................\\....|..............\\.....................|.....\\......\\............../..
.....\\......-.........-.\\.|..........|...............-.................|..........-............../............
.........-...................-.............................................-.........../...................|.-
....................\\..\\........|-.\\...............-............/....|..................../...................
.\\.........-........................|..-.......|.......-...........-.-...................\\/...\\....|....\\.....
.-........-./.....-.....\\.......-..........\\..-........\\..-.....................................\\..../...|....
....-.........................|..\\.....................................\\./...............-............/.......
..........|..\\....-........./..............................|........................-.......|./|........\\.....
..\\.........|..|..-|........\\...-................|/..\\......../.......-|..................||.-./..............
.--..-.......-........./.................\\....../.................-............................--.........-...
.......|.........../......./........../..\\.........\\...\\../..\\..././.......-..................................
.........-/...............|..\\|.................\\...........|............../............\\.....................
..........-.........\\.-................|-..................../......../...|/...\\..-....|-........-.......-....
.--|.\\|.......|.....-............................|.-....-...|...................|........../..................
.....-......./..../.|...................|\\..-.........../...|.............................\\/../........../....
......./........|.\\......-../...........\\........................./..........\\.........-...\\................|.
./.......................\\........-......|...|............................/............\\....-.....|..../...\\..
....................-..............-..-.............../..\\...../.\\.........\\................../.....\\.....-...
...................../......-....-.......|....|......../..|-...............\\..\\../.-.....././..........|......
..\\.....|...\\............................./.../...../..../......../...........................................
./.../................................../.....-.........|.....|..........-...............................-....
...............|..\\...-................................\\.........................|....\\...............-.-.....
/........|.......|.....-.......-..-..-.\\.................................-.\\...-.......\\.............-..\\.....
./......|../......|................................/.........||.-....................|..\\.........-....|../...
|..................................................\\......|...-............................../.......-........
....../...............-....-..................\\....-../................................./.\\.................-.
......-...........-...../.....-......|..........\\.\\...-......../......\\................--..............-......
.............\\/........|...../...........-.......\\...|........................................................
...\\\\........\\..........|...\\............/........-..../....-.....................-......................../..
.......-......../......./..........-....|....-..\\.........................\\.............../..........-.....-..
.....|\\/..../.........|.........../|.....\\.......-........-............../..././.............|................
.........|....|....\\..-....../............/.....\\/....|.............\\........................|.........-......
.\\\\..........................//......................\\....\\...........................-.|/....................
...................|...................-.|........................................../..........\\..............
......\\..|....../...........\\.-.........-.......-..|../........../.............................../.......-...|
..........|................/|.....-.....\\................||........./.............|.........../..-..|./.......
............../../|.......\\...............-..../|..../-..|................................../......-....|..|..
............\\...............\\.........................\\....-.............-..|/.....--...................-...-.
.....|\\......\\...........................-.................-.......\\...............|............|........../..
.....\\...-.............|............\\........\\...../.-...........|.-.................\\.........|..............
......./......\\..-............|..-...\\......................\\..........|....../..........|........./.......\\.-
..-.....|........./|............./.....................|...|.\\....-.......-..........|...\\.\\|-........\\....|..
......................../............-...........|...................../............-.......\\.........-.......
......../..............-./...................................--........................\\....-.......-..//.....
........|.....-....................|...../..............-..........-......|..\\................................
.......-..//.............../.....-......................./..|........./...........-..../..|.........-.........
.-...............-...........................\\.......\\...........-..................-.|...\\..\\.....\\..\\.....\\.
.........-../............|......|.|.........................\\.......-......\\...\\..............-../.../-\\......
.-...........-..|.....\\/........-.|...................../.|........-...........\\..........\\.....\\/|..../...\\.\\
.-..........\\.\\-..\\....-\\/................./.\\.......|.........................-............./....\\........./.
.............\\.........|............/...........\\\\................./..-..........................|//.......\\..
..../-........-.........................-\\...........|................./..........|.............|.\\..|........
...-..|.....\\..-..\\.................\\-.................|...../.-..........|........|/...-.-.\\.................
.-.-............................|.....\\..-..........|/|.........|....\\............\\.....\\..-...........|/...|.
......................../...............|..-............................-.........|........../.-....../.......
.........|-...................|.....................-...........|.../..............................|....-...-.
..............|....................................................|.....|.......--.....\\...\\.............../.
..-...............|........|..................-............|.........../.....\\................................
........................|.........|............-....-..\\../..................\\..|......\\.........\\../.../.....
.|............................./..............-....-.......--....-.../..........|.....\\.........-/.....|-./...
....-..............|...-.....\\.....\\/.-........................................-.\\.............|...../|/......
........./..-................/........./..............-............................................-....-.....
...........-........./...................../.........-........-................./.|...........................
............................................................-.............-..-......|..........-.\\............
....\\/........................-../.../.................................\\............/..........|./-......-...\\
....-............../..-.\\.......|......-...|...|.........../......|../...........|..-.\\.................../...
...-......../....-........................|...-............-.........................|/.....|.........|......-
...|........-.......-.......|...|\\.......\\............-...-...................................-|........-.....
....\\/..-.....-.....-..--./-..-............../................|............\\.............../.......|..........
.........-.\\.......-......|........-.............|..../..............\\-.....\\..........-..../.................
.................-......\\|.--..../../.-......-.......-........\\....-...../....................../.............
...../..../....../.............-......\\..........|..........\\..\\........-.-...................................
..............................|........./........-..................|.............-.../.................\\..-..
.....|./......-........\\...\\.................|....-........|..............|...................................
\\...|............................-..|.............../..............|.../......-......-.........../....../.....
..../.............................-..........\\.....\\-..................................-........../...........
..........................\\....................-...-/.|....................../................................
\\.......|.........-............\\\\...............-...-...................../...................................
..\\...................................-................................................../.......\\.|..........
...............................-................/........\\....\\.......|...................-.../.....|.........
...-..-............-.||..../././..........-\\\\............||...............-.\\.........../...\\........|...\\...|
....\\./.|./...................\\..-.-./..-.....||............../............|.......\\.|...../..................
......-.......\\.\\.........\\......|..\\...\\.-|.\\..............|...|......\\......./...\\........................-.
........./.-......../....|..............................|...|...\\........//./.................................
.........................|...........\\...........|.....................\\........//..-.................\\-/.....
.\\....................\\..-.-..-..........|/.\\..........\\././.....................|............\\....|...|/.....
......./.................../...-.................\\.........../.........\\................|....................|
......-..\\....|..................\\............\\........|......|....../........................................
.........\\/..............|.............\\.........-............-...........\\.\\..\\./....../.....//..............
.........../...\\.......-.../.-.............\\../....\\|./............/...-..\\........|..|/.....\\......\\\\........
..|............/..............................................-./...-.|..........-......../...................
...............-..|.......\\.............\\..../.....................|..........\\...................\\.....\\./\\..
.|..........\\..\\...|......................\\...........-.......--........................-.....................
...................../................\\.|..........-..|................-................................-.....
...../.........|-............|.\\.|.../\\.....|../........\\../..................................................
................/........\\../.....................\\./..../...........-............\\-......../../..\\.|.........
..............|.........-......|/......././.....|..../.|...........-.....................|./.-.....\\...|......
.......|..-.......\\..........|................................................/..\\.....-..........-...........
"""

    public static let Example1 = """
.|...\\....
|.-.\\.....
.....|-...
........|.
..........
.........\\
..../.\\\\..
.-.-/..|..
.|....-|.\\
..//.|....
"""
}
