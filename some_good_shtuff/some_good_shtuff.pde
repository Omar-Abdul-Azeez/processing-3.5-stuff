Fireworks Fireworks;

void setup() {
  fullScreen();
  Fireworks = new Fireworks(0.02, 9.8);
}

void draw() {
  background(0);
  Fireworks.RenderFireworks();
}
