package command;

import observer.Tile;

public class FlagTileCommand implements Command {
    Tile tile;

    public FlagTileCommand(Tile tile) {
        this.tile = tile;
    }

    @Override
    public void execute() {

    }
}
