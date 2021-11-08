import controlP5.*; //<>//
boolean increment;
int n=0;
ControlP5 control;
void setup() {
  fullScreen();
  control=new ControlP5(this);
  control.addTextfield("Number of squares=2^x").setPosition(20,20).setSize(100,22).setAutoClear(false);
  control.addBang("Set_x").setPosition(20+110,20).setSize(50,22);
  for (int i=0; i<RObj.length; i++) {
    RObj[i]=new Squares();
  }
}
float Rot=PI/pow(2, n-1);
Squares[] RObj=new Squares[(int)(TWO_PI/Rot)];
void draw() {
  background(0);
  noFill();
  stroke(255, 0, 0);
  strokeWeight(8);
  rectMode(CENTER);
  translate(width/2, height/2);
  for (int i=0; i<TWO_PI/Rot; i++) {
    rotate(Rot);
    RObj[i].RenderSquare(500);
  }
  translate(-width/2,-height/2);
  //saveFrame("frames/####.png");
}
void mousePressed() {
  increment=!increment;
}
void Set_x() {
  increment=!increment;
  n=Integer.valueOf(control.get(Textfield.class,"Number of squares=2^x").getText());
  Rot=PI/pow(2, n-1);
  RObj=new Squares[(int)(TWO_PI/Rot)];
    for (int i=0; i<RObj.length; i++) {
    RObj[i]=new Squares();
  }
}
