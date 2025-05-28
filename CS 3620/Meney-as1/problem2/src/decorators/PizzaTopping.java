package decorators;

import components.Pizza;

/**
 * Abstract class for pizza toppings.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public abstract class PizzaTopping extends Pizza {

    /**
     * Returns the description of the pizza with a topping.
     *
     * @return the description of the pizza with a topping
     */
    public abstract String getDescription();
}
