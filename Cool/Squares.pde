class Squares {
  float x=0;
  float y=0;
  void RenderSquare(float l) {
    if (increment)
      rect(x++, y++, l, l);
    else {
      x=0;
      y=0;
      rect(x, y, l, l);
    }
  }
}
