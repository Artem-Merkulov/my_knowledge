from create_l_system import main

main(
    axiom="F",
    rules = {"F": "+F--F+"},
    iterations = 10,  # TOP: 16
    angle = 45
)