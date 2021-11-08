import java.util.Collections; //<>//
double dynamicFrictionCoefficient, staticFrictionCoefficient, mass, radius, force, gravity, netForce, velocity, acceleration;
double mx, fx, gx, sfcx, dfcx;
double mFraction=(double)2/5, fFraction=2, gFraction=(double)1/5, sfcFraction=(double)1/250, dfcFraction;
double ballx, bally;
boolean mActive, fActive, gActive, sfcActive, dfcActive;
int screenDistance=10000;
double distanceScale=(double)width/screenDistance;
int moving;
ArrayList<Double> velocityValues, accelerationValues;
void setup() {
  fullScreen();
  reset();
}
void draw() {
  background(0, 102, 153);
  drawSliders();
  drawSimulation();
  updateSimulation();
  drawGraphs();
}
void reset() {
  velocityValues=new ArrayList<Double>();
  accelerationValues=new ArrayList<Double>();
  moving=0;
  mActive=false;
  fActive=false;
  gActive=false;
  sfcActive=false;
  dfcActive=false;
  force=0;
  netForce=0;
  velocity=0;
  acceleration=0;
  mass=100;
  gravity=9.8;
  staticFrictionCoefficient=0.2;
  dynamicFrictionCoefficient=0.1;
  mx=mass/mFraction;
  fx=250;
  gx=gravity/gFraction;
  sfcx=staticFrictionCoefficient/sfcFraction;
  dfcFraction=staticFrictionCoefficient/500;
  dfcx=dynamicFrictionCoefficient/dfcFraction;
  radius=sqrt((float) mass/PI)*12;
  ballx=0;
  bally=4*height/5-radius*2;
}
void drawSliders() {
  fill(0);
  textAlign(RIGHT, TOP);
  textSize(18);
  text("Mass:", 270, 40);
  text("Force:", 270, 67);
  text("Gravity:", 270, 94);
  text("Static Friction Coefficient:", 270, 121);
  text("Dynamic Friction Coefficient:", 270, 148);
  textAlign(LEFT, TOP);
  text(mass+"", 810, 40);
  text(force+"", 810, 67);
  text(gravity+"", 810, 94);
  text(staticFrictionCoefficient+"", 810, 121);
  text(dynamicFrictionCoefficient+"", 810, 148);
  fill(80);
  stroke(0);
  rect(280, 40, 520, 22);
  rect(280, 67, 520, 22);
  rect(280, 94, 520, 22);
  rect(280, 121, 520, 22);
  rect(280, 148, 520, 22);
  noStroke();
  fill(0, 255, 0);
  rect(280+(float)mx, 40, 20, 22);
  rect(280+(float)fx, 67, 20, 22);
  rect(280+(float)gx, 94, 20, 22);
  rect(280+(float)sfcx, 121, 20, 22);
  rect(280+(float)dfcx, 148, 20, 22);
}
void drawGraphs() {
  double lineLength=bally-50-180;
  stroke(0);
  fill(0);
  strokeWeight(2);
  line(90, 180, 90, 180+(float)lineLength);
  line(90, 180+(float)lineLength/2, 90+(float)lineLength, 180+(float)lineLength/2);
  triangle(90, 172, 90-8/sqrt(3), 180, 90+8/sqrt(3), 180);
  triangle(90, 180+(float)lineLength+8, 90-8/sqrt(3), 180+(float)lineLength, 90+8/sqrt(3), 180+(float)lineLength);
  triangle(90+(float)lineLength+8, 180+(float)lineLength/2, 90+(float)lineLength, 180+(float)lineLength/2-8/sqrt(3), 90+(float)lineLength, 180+(float)lineLength/2+8/sqrt(3));
  line(692, 180, 692, 180+(float)lineLength);
  line(692, 180+(float)lineLength/2, 692+(float)lineLength, 180+(float)lineLength/2);
  triangle(692, 172, 692-8/sqrt(3), 180, 692+8/sqrt(3), 180);
  triangle(692, 180+(float)lineLength+8, 692-8/sqrt(3), 180+(float)lineLength, 692+8/sqrt(3), 180+(float)lineLength);
  triangle(692+(float)lineLength+8, 180+(float)lineLength/2, 692+(float)lineLength, 180+(float)lineLength/2-8/sqrt(3), 692+(float)lineLength, 180+(float)lineLength/2+8/sqrt(3));
  fill(0);
  textAlign(RIGHT, CENTER);
  text("Velocity", 80, 180);
  double velocityFraction=Collections.max(velocityValues)>-Collections.min(velocityValues)? Collections.max(velocityValues):-Collections.min(velocityValues);
  velocityFraction=velocityFraction==0? 0:lineLength/2/velocityFraction;
  beginShape();
  noFill();
  stroke(255, 0, 255);
  for (int i=0; i<velocityValues.size(); i++) {
    vertex(90+i*(float)lineLength/500, 180+(float)lineLength/2-(float)(double)velocityValues.get(i)*(float)velocityFraction);
  }
  endShape();
  textAlign(LEFT, CENTER);
  text(velocity+"", 100+(float)lineLength, 180+(float)lineLength/2-(float)velocity*(float)velocityFraction);
  textAlign(RIGHT, CENTER);
  text("Acceleration", 680, 180);
  double accelerationFraction=Collections.max(accelerationValues)>-Collections.min(accelerationValues)? Collections.max(accelerationValues):-Collections.min(accelerationValues);
  accelerationFraction=accelerationFraction==0? 0:lineLength/2/accelerationFraction;
  beginShape();
  noFill();
  stroke(255, 0, 255);
  for (int i=0; i<accelerationValues.size(); i++) {
    vertex(692+i*(float)lineLength/500, 180+(float)lineLength/2-(float)(double)accelerationValues.get(i)*(float)accelerationFraction);
  }
  endShape();
  textAlign(LEFT, CENTER);
  text(acceleration+"", 702+(float)lineLength, 180+(float)lineLength/2-(float)acceleration*(float)accelerationFraction);
  strokeWeight(1);
}
void updateValues() { 
  if (pmouseX>280+mx && pmouseY>40 && pmouseX<280+mx+20 && pmouseY<62) mActive=true;
  else if (pmouseX>280+fx && pmouseY>67 && pmouseX<280+fx+20 && pmouseY<89) fActive=true;
  else if (pmouseX>280+gx && pmouseY>94 && pmouseX<280+gx+20 && pmouseY<116) gActive=true;
  else if (pmouseX>280+sfcx && pmouseY>121 && pmouseX<280+sfcx+20 && pmouseY<143) sfcActive=true;
  else if (pmouseX>280+dfcx && pmouseY>148 && pmouseX<280+dfcx+20 && pmouseY<170) dfcActive=true;
  if (mActive) {
    if (mouseX-290<0) mx=0;
    else if (mouseX-290>500) mx=500;
    else mx=mouseX-290;
    mass=mx*mFraction;
    radius=sqrt((float)mass/PI)*12;
    bally=4*height/5-radius*2;
  } else if (fActive) {
    if (mouseX-290<0) fx=0;
    else if (mouseX-290>500) fx=500;
    else fx=mouseX-290;
    force=(fx-250)*fFraction;
  } else if (gActive) {
    if (mouseX-290<0) gx=0;
    else if (mouseX-290>500) gx=500;
    else gx=mouseX-290;
    gravity=gx*gFraction;
  } else if (sfcActive) {
    if (mouseX-290<0) sfcx=0;
    else if (mouseX-290>500) sfcx=500;
    else sfcx=mouseX-290;
    staticFrictionCoefficient=sfcx*sfcFraction;
    dfcFraction=staticFrictionCoefficient/500;
    dynamicFrictionCoefficient=dfcx*staticFrictionCoefficient/500;
  } else if (dfcActive) {
    if (mouseX-290<0) dfcx=0;
    else if (mouseX-290>500) dfcx=500;
    else dfcx=mouseX-290;
    dynamicFrictionCoefficient=dfcx*dfcFraction;
  }
}
void drawSimulation() {
  fill(0, 255, 0);
  noStroke();
  rect(0, 4*height/5, width, height/5);
  fill(255, 0, 0);
  ellipseMode(CORNER);
  ellipse((float)ballx, (float)bally, (float)radius*2, (float)radius*2);
  if (ballx+radius*2>width) ellipse((float)-radius*2+(float)ballx+(float)radius*2-width, (float)bally, (float)radius*2, (float)radius*2);
  else if (ballx<0) ellipse(width-(float)ballx, (float)bally, (float)radius*2, (float)radius*2);
}
void updateSimulation() {
  if (ballx>width)ballx=0;
  else if (ballx+radius*2<0)ballx=width;
  if (moving!=0) {
    if ((force>=0 && moving>0) || (force<0 && moving>0)) netForce=force-dynamicFrictionCoefficient*mass*gravity;
    else netForce=force+dynamicFrictionCoefficient*mass*gravity;
    acceleration=netForce/mass;
    velocity+=acceleration;
    if (moving>0 == velocity>0)
      ballx+=velocity*distanceScale;
    else {
      velocity=0;
      if (!(force>staticFrictionCoefficient*mass*gravity || -force>staticFrictionCoefficient*mass*gravity)) acceleration=0;
      moving=0;
    }
  } else if (force>staticFrictionCoefficient*mass*gravity) {    
    moving=1;
    netForce=force-dynamicFrictionCoefficient*mass*gravity;
    acceleration=netForce/mass;
    velocity+=acceleration;
    ballx+=velocity*distanceScale;
  } else if (-force>staticFrictionCoefficient*mass*gravity) {
    moving=-1;
    netForce=force+dynamicFrictionCoefficient*mass*gravity;
    acceleration=netForce/mass;
    velocity+=acceleration;
    ballx+=velocity*distanceScale;
  }
  velocityValues.add(velocity);
  accelerationValues.add(acceleration);
  if (velocityValues.size()>500) velocityValues.remove(0);
  if (accelerationValues.size()>500) accelerationValues.remove(0);
}
void mouseDragged() {
  if (mouseButton==LEFT)
    updateValues();
}
void mousePressed() {
  if (mouseButton==RIGHT)
    reset();
  else if (mouseButton==LEFT)
    if (pmouseX>280 && pmouseY>40 && pmouseX<800 && pmouseY<62) 
      if (mouseX-290<0) mx=0;
      else if (mouseX-290>500) mx=500;
      else mx=mouseX-290;
    else if (pmouseX>280 && pmouseY>67 && pmouseX<800 && pmouseY<89) 
      if (mouseX-290<0) fx=0;
      else if (mouseX-290>500) fx=500;
      else fx=mouseX-290;
    else if (pmouseX>280 && pmouseY>94 && pmouseX<800 && pmouseY<116) 
      if (mouseX-290<0) gx=0;
      else if (mouseX-290>500) gx=500;
      else gx=mouseX-290;
    else if (pmouseX>280 && pmouseY>121 && pmouseX<800 && pmouseY<143) 
      if (mouseX-290<0) sfcx=0;
      else if (mouseX-290>500) sfcx=500;
      else sfcx=mouseX-290;
    else if (pmouseX>280 && pmouseY>148 && pmouseX<800 && pmouseY<170) 
      if (mouseX-290<0) dfcx=0;
      else if (mouseX-290>500) dfcx=500;
      else dfcx=mouseX-290;
}
void mouseReleased() {
  mActive=false;
  fActive=false;
  gActive=false;
  sfcActive=false;
  dfcActive=false;
}
