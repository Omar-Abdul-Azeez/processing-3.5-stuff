Minesweeper_Game sweeper;
boolean solve, c;
void setup() {
  size(1000, 1000);
  sweeper = new Minesweeper_Game();
}

void draw() {
  background(255);
  if (c) {
    sweeper.newLevel();
    c=!c;
  }
  sweeper.render
    if (solve)
    solve=sweeper.solve();
}

void keyPressed() {
  if (key=='n' || key=='N')
    c=true;
  if ((key=='s' || key=='S'))
    solve=true;
}
void mousePressed() {
  sweeper.press(mouseButton);
}
