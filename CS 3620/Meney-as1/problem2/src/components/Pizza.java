package components;

/**
 * Abstract class for pizza related components or decorators.
 *
 * @author Jonathon Meney
 * @version 1.0, 01/30/24
 */
public abstract class Pizza {
    /**
     * The description of the pizza.
     */
    protected String description = "Unknown Pizza";


    /**
     * Returns the cost of the pizza.
     *
     * @return the cost of the pizza
     */
    public abstract double cost();

    /**
     * Returns description of pizza.
     *
     * @return the description of the pizza component or decorator
     */
    public String getDescription() {
        return description;
    }
}
