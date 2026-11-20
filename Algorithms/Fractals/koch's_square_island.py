from create_l_system import main

main(
    axiom="F+F+F+F",
    rules = {"F": "F-F+F+FFF-F-F+F"},
    iterations = 2,  # TOP: 4
    angle = 90
)