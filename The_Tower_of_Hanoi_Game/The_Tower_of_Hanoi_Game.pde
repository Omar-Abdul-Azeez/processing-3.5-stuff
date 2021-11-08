The_Tower_of_Hanoi Tower;
PFont Font;
int Speed;
void setup() {
  fullScreen();
  frameRate(1200);
  Tower = new The_Tower_of_Hanoi();
  Font =createFont("OpenSans-Semibold.ttf", 32);
  textFont(Font);
  Speed=1;
}

void draw() {
  for (int i=0; i<Speed; i++) {
    Tower.InitializeGame();
    Tower.SolveGame();
    fill(255, 0, 0);
    textAlign(LEFT, BOTTOM);
    if (Tower.DiscsNum<60) text("N - Next level", 0, height-32);
    if (Tower.DiscsNum>1) text("P - Previous level", 0, height);
    text("F - Double the speed (Upto x16)",400,height-32);
    text("S - Halve the speed",400,height);
  }
}

void keyPressed() {
  if (Tower.DiscsNum<60 && (key=='n' || key=='N')) {
    Tower.NextLevel();
  }
  if (Tower.DiscsNum>1 && (key=='p' || key=='P')) {
    Tower.PreviousLevel();
  }
  if (Speed<16 && (key=='f' || key=='F')) {
    Speed*=2;
  }
  if (Speed>1 && (key=='s' || key=='S')) {
    Speed/=2;
  }
}
