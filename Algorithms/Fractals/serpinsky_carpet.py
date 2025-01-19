from create_l_system import main

main(
    axiom="YF",
    rules = {"X": "YF+XF+Y", "Y": "XF-YF-X"},
    iterations = 10,  # TOP: 10
    angle = 60
)