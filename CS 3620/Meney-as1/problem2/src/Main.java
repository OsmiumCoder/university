import components.LargePizza;
import components.MediumPizza;
import components.Pizza;
import components.SmallPizza;
import decorators.*;

public class Main {
    public static void main(String[] args) {
        Pizza largePizza = new LargePizza();
        largePizza = new Onions(largePizza);
        largePizza = new Mushrooms(largePizza);
        System.out.printf("%s $%.2f\n", largePizza.getDescription(), largePizza.cost());

        Pizza smallPizza = new SmallPizza();
        smallPizza = new Bacon(smallPizza);
        smallPizza = new Mushrooms(smallPizza);
        smallPizza = new Bacon(smallPizza);
        System.out.printf("%s $%.2f\n", smallPizza.getDescription(), smallPizza.cost());

        Pizza mediumPizza = new MediumPizza();
        mediumPizza = new BlackOlives(mediumPizza);
        mediumPizza = new Sausage(mediumPizza);
        System.out.printf("%s $%.2f\n", mediumPizza.getDescription(), mediumPizza.cost());
    }
}