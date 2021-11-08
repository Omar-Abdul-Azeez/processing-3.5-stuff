Visual visual;
void setup() {
  fullScreen();
  visual = new Visual(Visual.TRIGNOMETRIC, 2); //SPEED HAS TO BE A FACTOR OF 90: 1, 2, 3, 5, 6, 9, 10, 15, 18, 30, 45, 90
}

void draw() {
  background(0);
  visual.tick();
  visual.render();
}
