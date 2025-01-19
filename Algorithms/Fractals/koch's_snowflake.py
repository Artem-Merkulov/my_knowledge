from create_l_system import main

main(
    axiom = "F--F--F",
    rules = {"F":"F+F--F+F"},
    iterations = 4, # TOP: 7
    angle = 60
)