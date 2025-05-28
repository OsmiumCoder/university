package decorators;

import components.Pizza;

/**
 * Class to represent a pepperoni topping.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class Pepperoni extends PizzaTopping {
    /**
     * The pizza the topping is on.
     */
    private final Pizza pizza;

    /**
     * Constructs a Pepperoni topping for a given pizza.
     *
     * @param pizza the pizza the topping is on
     */
    public Pepperoni(Pizza pizza) {
        this.pizza = pizza;
    }

    @Override
    public double cost() {
        return 1.45 + pizza.cost();
    }

    @Override
    public String getDescription() {
        return pizza.getDescription() + ", Pepperoni";
    }
}
