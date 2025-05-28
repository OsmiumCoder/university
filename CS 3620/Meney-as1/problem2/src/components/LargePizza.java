package components;

/**
 * Class to represent a large pizza.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class LargePizza extends Pizza {

    /**
     * Constructs a LargePizza.
     */
    public LargePizza() {
        description = "Large Pizza";
    }

    @Override
    public double cost() {
        return 12.15;
    }
}
