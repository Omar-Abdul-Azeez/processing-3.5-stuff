class Minesweeper_Game {
  Grid<Cell> cells;
  float w, h;
  boolean failed;

  class Cell {
    int neighbours;
    boolean mine, flagged, revealed;

    Cell(boolean mine) {
      this.mine=mine;
    }

    void setNeighbours(int num) {
      neighbours=num;
    }
    void setFlag(boolean state) {
      flagged=state;
    }
    void setReveal(boolean state) {
      revealed=state;
    }
    int getNeighbours() {
      return neighbours;
    }
    boolean isMine() {
      return mine;
    }
    boolean isRevealed() {
      return revealed;
    }
    boolean isFlagged() {
      return flagged;
    }
  }

  Minesweeper_Game() {
    cells=new Grid<Cell>(Cell.class, 50, 50);
    w=20;
    h=20;
  }

  void newLevel() {
    for (int i=0; i<cells.xSize(); ++i) {
      for (int j=0; i<cells.ySize(); ++j) {
        if (random(100)>=85)
          cells.store(new int[]{i, j}, new Cell(true));
        else
          cells.store(new int[]{i, j}, new Cell(false));
      }
    }
    int counter;
    for (int i=0; i<cells.xSize(); ++i) {
      for (int j=0; i<cells.ySize(); ++j) {
        if (cells.get(new int[]{i, j}).isMine()) continue;
        counter=0;
        for (int k=-1; k<2; ++k) {
          for (int l=-1; l<2; ++l) {
            if (i+k>=0 && j+l>=0 && !(k==0 && l==0) && i+k<cells.xSize() && j+l<cells.ySize())
              counter=cells.get(new int[]{i+k, j+l}).isMine()?counter+1:counter;
          }
        }
        cells.get(new int[]{i, j}).setNeighbours(counter);
      }
    }
  }

  void render() {
    
  }

  void solve() {
    
  }

  void press() {
    
  }
}
