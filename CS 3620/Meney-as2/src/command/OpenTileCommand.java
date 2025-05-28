package command;

import observer.Tile;

public class OpenTileCommand implements Command {
    Tile tile;

    public OpenTileCommand(Tile tile) {
        this.tile = tile;
    }


    @Override
    public void execute() {

    }
}
