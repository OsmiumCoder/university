package components;

/**
 * Class to represent a medium pizza.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public class MediumPizza extends Pizza {

    /**
     * Constructs a MediumPizza.
     */
    public MediumPizza() {
        description = "Medium Pizza";
    }
    @Override
    public double cost() {
        return 6.95;
    }
}
