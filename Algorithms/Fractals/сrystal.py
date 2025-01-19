from create_l_system import main

main(
    axiom="F+F+F+F",
    rules = {"F": "FF+F++F+F"},
    iterations = 3,  # TOP: 6
    angle = 90
)