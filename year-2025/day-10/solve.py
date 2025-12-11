
import re
import sys
from z3 import *

def parse_machine(line: str):
    buttons: list[list[int]] = []
    joltage: list[int] = []

    elements = line.split("] ")
    elements = elements[1].split(" {")
    elements[1] = elements[1][:-1]

    for button_data in elements[0].split(" "):
        button = []
        for index in button_data.split(","):
            index = index.replace("(", "").replace(")", "")
            button.append(int(index))
        buttons.append(button)

    for joltage_data in elements[1].split(","):
        joltage.append(int(joltage_data))

    return buttons, joltage

def find_min_presses(buttons, joltage) -> int | None:
    optimize = Optimize()

    # Presses are x<n> unknown Z3 Integers
    button_slams = [Int(f'x{i}') for i in range(len(buttons))]

    # Must be a non-negative number
    for x in button_slams:
        optimize.add(x >= 0)

    # Button sum must equal the joltage level
    for joltage_index, level in enumerate(joltage):
        buttons_for_joltage = []
        for button_index, button in enumerate(buttons):
            if joltage_index in button:
                buttons_for_joltage.append(button_slams[button_index])

        optimize.add(Sum(buttons_for_joltage) == level)

    result = Sum(button_slams)
    optimize.minimize(result)

    if optimize.check() == sat:
        model = optimize.model()
        return model.eval(result).as_long()
    else:
        return None


if __name__ == "__main__":
    input = sys.argv[1]
    result = 0
    for line in input.split("\n"):
        buttons, joltage = parse_machine(line)
        result += find_min_presses(buttons, joltage)

    # Print result to stdout
    print(result)
