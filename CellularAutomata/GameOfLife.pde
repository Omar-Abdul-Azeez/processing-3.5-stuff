class GameOfLife { //<>//
  private Grid<Boolean> curGen, nextGen;
  private final boolean wrapAround;
  private float cellWidth, cellHeight;
  private int n, offset;

  GameOfLife(boolean wrapAround) {
    this(wrapAround, new Grid<Boolean>(Boolean.class, wrapAround?width/10:width/10+20, wrapAround?height/10:height/10+20));
  }

  GameOfLife(boolean wrapAround, Grid<Boolean> currentGeneration) {
    curGen=currentGeneration;
    this.wrapAround=wrapAround;
    cellWidth=10;
    cellHeight=10;
    offset=wrapAround?0:10;
  }

  void newGen() {
    int offset=this.offset*2+50;
    for (int i=0; i<curGen.xSize(); i++) {
      for (int j=0; j<curGen.ySize(); j++) {
        if 
          (random(100)>=85)
          //(i>40 && j>40 && i<curGen.xSize()-40 && j<curGen.ySize()-40)
          //((i==7+offset && j==1+offset) || (i>0+offset && i<3+offset && j==2+offset) || ((i==2+offset || (i>5+offset && i<9+offset)) && j==3+offset))
          //(j==1+offset && ((i>0+offset && i<9+offset) || (i>9+offset && i<15+offset) || (i>17+offset && i<21+offset) || (i>26+offset && i<34+offset) || (i>34+offset && i<40+offset)))
          //((((i>0+offset && i<4+offset) || i==5+offset) && j==1+offset) || (i==1+offset && j==2+offset) || (i>3+offset && i<6+offset && j==3+offset) || (((i>1+offset && i<4+offset)||i==5+offset) && j==4+offset) || ((i==1+offset || i==3+offset || i==5+offset) && j==5+offset))
          //((i>3+offset && i<7+offset && (j==2+offset || j==7+offset || j==9+offset || j==14+offset)) || (i>9+offset && i<13+offset && (j==2+offset || j==7+offset || j==9+offset || j==14+offset)) || (j>3+offset && j<7+offset && (i==2+offset || i==7+offset || i==9+offset || i==14+offset)) || (j>9+offset && j<13+offset && (i==2+offset || i==7+offset || i==9+offset || i==14+offset)))
          curGen.store(new int[]{i, j}, true);
else
  curGen.store(new int[]{i, j}, false);
}
}
}

void render() {
  rectMode(CORNERS);
  stroke(100);
  for (int i=offset; i<curGen.xSize()-offset; i++) {
    for (int j=offset; j<curGen.ySize()-offset; j++) {
      if (curGen.get(new int[]{i, j}))
        fill(0);
      else
        noFill();
      rect(cellWidth*(i-offset), cellHeight*(j-offset), cellWidth*(i+1-offset), cellHeight*(j+1-offset));
    }
  }
}

void nextGen() {
  int counter;
  nextGen=new Grid(Boolean.class, curGen.xSize(), curGen.ySize());
  for (int i=0; i<curGen.xSize(); i++) {
    for (int j=0; j<curGen.ySize(); j++) {
      if (!wrapAround && n==100 && (i<offset || j<offset || i>curGen.xSize()-offset-1 || j>curGen.ySize()-offset-1)) {
        nextGen.store(new int[]{i, j}, false);
        continue;
      }
      counter=0;
      for (int k=-1; k<2; ++k) {
        for (int l=-1; l<2; ++l) {
          if (wrapAround) {
            if (!(k==0 && l==0))
              counter=curGen.get(new int[]{i+k==-1?curGen.xSize()-1:i+k==curGen.xSize()?0:i+k, j+l==-1?curGen.ySize()-1:j+l==curGen.ySize()?0:j+l})?counter+1:counter;
          } else if (i+k>=0 && j+l>=0 && !(k==0 && l==0) && i+k<curGen.xSize() && j+l<curGen.ySize())
            counter=curGen.get(new int[]{i+k, j+l})?counter+1:counter;
        }
      }
      if (curGen.get(new int[]{i, j}))
        if (counter==2 || counter==3)
          nextGen.store(new int[]{i, j}, true);
        else
          nextGen.store(new int[]{i, j}, false);
      else
        if (counter==3)
          nextGen.store(new int[]{i, j}, true);
        else
          nextGen.store(new int[]{i, j}, false);
    }
  }
  if (!wrapAround)
    if (n==100)
      n=0;
    else
      ++n;
  curGen=nextGen;
}
boolean hasCurrent() {
  return curGen.get(new int[]{0, 0})!=null;
}
boolean[][] curGen() {
  boolean[][] code = new boolean[curGen.xSize()][curGen.ySize()];
  for (int i=0; i<code.length; i++) {
    for (int j=0; j<code[0].length; j++) {
      code[i][j]=curGen.get(new int[]{i, j});
    }
  }
  return code;
}
}
