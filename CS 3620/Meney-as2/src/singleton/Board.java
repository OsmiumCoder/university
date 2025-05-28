package singleton;

public class Board {
    private static Board instance = null;

    private Board() {
    }

    public static Board getInstance() {
        if (instance == null) {
            synchronized (Board.class) {
                if (instance == null) {
                    instance = new Board();
                }
            }
        }
        return instance;
    }


}
