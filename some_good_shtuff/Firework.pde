class Firework { //<>//
  private Particle Firework;
  private ArrayList<Particle> Trail;
  private ArrayList<Particle> Afterwork;
  private ArrayList<Particle> ToRemove;
  private PVector TopLocation;
  private final float Gravity;
  private final float Mass;
  private float LifeSpan;
  private final int Shape;
  private boolean Finished;
  private boolean BOOMED;

  Firework(PVector location, float gravity) {
    TopLocation=new PVector();
    Trail=new ArrayList<Particle>();
    Afterwork= new ArrayList<Particle>();
    ToRemove=new ArrayList<Particle>();
    Gravity=gravity;
    LifeSpan=200;
    Mass=0.125;
    Shape=floor(random(1, 4));
    Firework= new Particle(location.copy(), Mass, new PVector(0, Gravity), new PVector(0, random(-41, -25)), 0.001, Mass/16, 255); //NEED BETTER WAY OF CALC-ING VELOCITY 
    for (int i=0; i<5; i++) {
      Trail.add(new Particle(new PVector(0, (i+1)*5).add(location.copy()), Mass/2, new PVector(0, Gravity*2), Firework.GetVelocity(), 0.001, Mass/32, 80));
    }
  }

  void RenderFirework() {
    if (Firework !=null) {
      Firework.RenderParticle();
      TopLocation=Firework.GetLocation();
      if (Firework.GetVelocity().y>=-0) {
        BOOM();
      }
    }
    for (Particle TrailParticle : Trail) {
      TrailParticle.RenderParticle();
      if (TrailParticle.GetLocation().y<=TopLocation.y) {
        ToRemove.add(TrailParticle);
      }
    }
    if (!ToRemove.isEmpty()) {
      Trail.removeAll(ToRemove);
      ToRemove.clear();
    }
    if (LifeSpan<=0) {
      Finished=true;
      Afterwork=new ArrayList<Particle>();
    }
    for (Particle Afterwork : Afterwork) {
      Afterwork.SetAlpha(LifeSpan+55);
      Afterwork.RenderParticle();
    }
    if (BOOMED) LifeSpan-=18;
    if (!ToRemove.isEmpty()) {
      Afterwork.removeAll(ToRemove);
      ToRemove.clear();
    }
  }

  private void BOOM() {
    TopLocation=Firework.GetLocation();
    BOOMED=true;
    switch (Shape) {
    case 1:
      Peony();
      break;
    case 2:
      Heart();
      break; 
    case 3:
      Ring();
      break;
    }
    Firework=null;
  }

  void Peony() {
    for (int i=0; i<100; i++) {
      Afterwork.add(new Particle(Firework.GetLocation().copy(), Mass, new PVector(0, Gravity/2), PVector.random2D().mult(random(10)), 0.0011, Mass/4, LifeSpan+55));
    }
  }

  void Heart() {
    float t;
    for (int i=0; i<100; i++) {
      t=random(-PI, PI+0.5);
      Afterwork.add(new Particle(Firework.GetLocation().copy(), Mass, new PVector(0, Gravity/2), new PVector(-16*pow(sin(t), 3), -13*cos(t)+5*cos(2*t)+2*cos(3*t)+cos(4*t)), 0.0011, Mass/4, LifeSpan+55));
    }
  }

  void Ring() {
    for (int i=0; i<50; i++) {
      Afterwork.add(new Particle(Firework.GetLocation().copy(), Mass, new PVector(0, Gravity/2), PVector.random2D().mult(8), 0.0011, Mass/4, LifeSpan+55));
    }
  }

  float GetGravity() {
    return Gravity;
  }
  float GetMass() {
    return Mass;
  }
  String GetShape() {
    switch (Shape) {
    case 1:
      return "Peony";
    case 2:
      return "Heart";
    default:
      return "Ring";
    }
  }
  boolean Finished() {
    return Finished;
  }
}
