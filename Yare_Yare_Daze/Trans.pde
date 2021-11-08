class Visual { //<>//
  static final int TRIGNOMETRIC=1;
  float X, Y, x, y, sin, cos, tan, theta;
  int  r, l, speed;
  ArrayList<float[]> sincurve, coscurve, tancurve;
  boolean inf;

  Visual(int visual, int speed) {
    r=120;
    X=r*2.2;
    Y=height/2;
    l=1000;
    this.speed=speed;
    theta=-speed;
    sincurve=new ArrayList<float[]>();
    coscurve=new ArrayList<float[]>();
    tancurve=new ArrayList<float[]>();
  }
  void tick() {
    theta= theta==360-speed? 0:theta+speed;
    sin=sin(radians(theta));
    cos=cos(radians(theta));
    if (theta==90 || theta==270)
      inf=true;
    else {
      inf=false;
      tan=tan(radians(theta));
    }
    x=X+cos*r;
    y=Y-sin*r;
    coscurve.add(0, new float[]{width-r-l+coscurve.size()*speed, -cos*r+Y});
    if (coscurve.size()>l/speed) {
      coscurve.remove(l/speed);
      for (int i=0; i<coscurve.size(); i++)
        coscurve.get(i)[0]-=speed;
    }
    sincurve.add(0, new float[]{width-r-l+sincurve.size()*speed, -sin*r+Y/2});
    if (sincurve.size()>l/speed) {
      sincurve.remove(l/speed);
      for (int i=0; i<sincurve.size(); i++)
        sincurve.get(i)[0]-=speed;
    }
    if (!inf)
      tancurve.add(0, new float[]{width-r-l+tancurve.size()*speed, -tan*4*speed+Y*3/2});
    else
      tancurve.add(0, new float[]{width-r-l+tancurve.size()*speed});
    if (tancurve.size()>l/speed) {
      tancurve.remove(l/speed);
      for (int i=0; i<tancurve.size(); i++)
        tancurve.get(i)[0]-=speed;
    }
  }
  void render() {
    strokeWeight(3);
    noFill();
    stroke(255);
    ellipseMode(CENTER);
    ellipse(X, Y, r*2, r*2);
    line(X-r*2, Y, X+r*2, Y);
    line(X, Y-r*2, X, Y+r*2);
    line(width-r-l, Y/2, width-r, Y/2);
    line(width-r-l, Y, width-r, Y);
    line(width-r-l, Y*3/2, width-r, Y*3/2);
    stroke(255, 0, 0);
    line(X, y, x, y);
    beginShape();
    for (float[] cord : sincurve)
      vertex(cord[0], cord[1]);
    endShape();
    stroke(0, 255, 0);
    line(x, Y, x, y);
    beginShape();
    for (float[] cord : coscurve)
      vertex(cord[0], cord[1]);
    endShape();
    stroke(0, 0, 255);
    line(x-sqrt(2)*r*sin, y-sqrt(2)*r*cos, x+sqrt(2)*r*sin, y+sqrt(2)*r*cos);
    beginShape();
    for (float[] cord : tancurve)
      if (cord.length==1) {
        endShape();
        beginShape();
      } else
        vertex(cord[0], cord[1]);
    endShape();
    stroke(255, 0, 255);
    strokeWeight(12);
    point(X, Y);
    point(x, y);
  }
}
