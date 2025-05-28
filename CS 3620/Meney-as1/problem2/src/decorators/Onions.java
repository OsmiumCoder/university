package decorators;

import components.Pizza;

/**
 * Class to represent an onions topping.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class Onions extends PizzaTopping {
    /**
     * The pizza the topping is on.
     */
    private final Pizza pizza;

    /**
     * Constructs a Onions topping for a given pizza.
     *
     * @param pizza the pizza the topping is on
     */
    public Onions(Pizza pizza) {
        this.pizza = pizza;
    }

    @Override
    public double cost() {
        return 1.15 + pizza.cost();
    }

    @Override
    public String getDescription() {
        return pizza.getDescription() + ", Onions";
    }
}
