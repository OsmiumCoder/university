package decorators;

import components.Pizza;

/**
 * Class to represent a bacon topping.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class Bacon extends PizzaTopping {
    /**
     * The pizza the topping is on.
     */
    private final Pizza pizza;

    /**
     * Constructs a Bacon topping for a given pizza.
     *
     * @param pizza the pizza the topping is on
     */
    public Bacon(Pizza pizza) {
        this.pizza = pizza;
    }

    @Override
    public double cost() {
        return 3.45 + pizza.cost();
    }

    @Override
    public String getDescription() {
        return pizza.getDescription() + ", Bacon";
    }
}
