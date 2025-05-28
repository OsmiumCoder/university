package components;

/**
 * Class to represent a small pizza.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class SmallPizza extends Pizza {

    /**
     * Constructs a SmallPizza.
     */
    public SmallPizza() {
        description = "Small Pizza";
    }

    @Override
    public double cost() {
        return 4.95;
    }
}
