package observer;

import java.util.ArrayList;

public class Tile implements Subject, Observer {
    private boolean opened;
    private int numbered;
    private boolean flagged;
    private boolean mined;
    private final ArrayList<Observer> neighbors;

    public Tile(boolean mined) {
        opened = false;
        numbered = 0;
        flagged = false;
        this.mined = mined;
        neighbors = new ArrayList<>();
    }

    @Override
    public void registerObserver(Observer observer) {
        neighbors.add(observer);
    }

    @Override
    public void removeObserver(Observer observer) {
        int index = neighbors.indexOf(observer);
        if (index >= 0) {
            neighbors.remove(index);
        }
    }

    @Override
    public void notifyObservers() {
        for (Observer observer : neighbors) {
            observer.update();
        }
    }

    @Override
    public void update() {

    }
}
