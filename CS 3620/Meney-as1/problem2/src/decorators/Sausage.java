package decorators;

import components.Pizza;

/**
 * Class to represent a sausage topping.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class Sausage extends PizzaTopping {
    /**
     * The pizza the topping is on.
     */
    private final Pizza pizza;

    /**
     * Constructs a Sausage topping for a given pizza.
     *
     * @param pizza the pizza the topping is on
     */
    public Sausage(Pizza pizza) {
        this.pizza = pizza;
    }

    @Override
    public double cost() {
        return 2.95 + pizza.cost();
    }

    @Override
    public String getDescription() {
        return pizza.getDescription() + ", Sausage";
    }
}
