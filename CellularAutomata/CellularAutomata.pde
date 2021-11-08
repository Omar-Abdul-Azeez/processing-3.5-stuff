int num=1, folder=1;
boolean c=true;
PrintWriter writer;
GameOfLife game;

void setup() {
  fullScreen();
  game=new GameOfLife(false);
  while (new File("Frames "+ folder).exists())
    folder++;
}

void draw() {
  background(255);
  if (c) {
    game.newGen();
    writer = createWriter("Frames " + folder + "\\" + num + "-2.txt");
    for (boolean[] s1 : game.curGen()) {
      for (boolean s2 : s1)
        writer.print((s2?1:0)+" ");
      writer.println();
      writer.println();
    }
    writer.close();
  }
  game.render();
  if (c) {
    saveFrame("Frames "+folder+"\\"+ num++ +"-1.tif"); //<>//
    c=false;
  }
  game.nextGen();
}

void keyPressed() {
  if (key=='n' || key=='N') {
    c=true;
  }
}
