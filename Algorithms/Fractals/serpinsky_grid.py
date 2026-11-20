from create_l_system import main

main(
    axiom="FXF--FF--FF",
    rules = {"F": "FF", "X": "--FXF++FXF++FXF--"},
    iterations = 5,  # TOP: 8
    angle = 60
)