The_Tower_of_Hanoi Tower;
PFont Font;

void setup() {
  fullScreen();
  frameRate(1200);
  Tower = new The_Tower_of_Hanoi();
  Font =createFont("OpenSans-Semibold.ttf", 32);
  textFont(Font);
}

void draw() {
  Tower.InitializeGame();
  Tower.SolveGame();
  fill(255, 0, 0);
  textAlign(LEFT, BOTTOM);
  if (Tower.DiscsNum<60) text("N - Next level", 0, height-32);
  if (Tower.DiscsNum>1) text("P - Previous level", 0, height);
}

void keyPressed() {
  if (Tower.DiscsNum<60 && (key=='n' || key=='N')) {
    Tower.NextLevel();
  }
  if (Tower.DiscsNum>1 && (key=='p' || key=='P')) {
    Tower.PreviousLevel();
  }
}
