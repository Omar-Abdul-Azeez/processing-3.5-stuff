class Particle {
  private PVector Location;
  private PVector Velocity;
  private PVector Acceleration;
  private final PVector Force;
  private float Mass;
  private float MassLoss;
  private final float MassLimit;
  private float Size;
  private float HUE;
  private float Alpha;

  Particle(PVector location, float mass, PVector force, PVector startingVelocity, float massLoss, float massLimit, float alpha) {
    HUE = random(0, 255);
    Alpha=alpha;
    MassLoss=massLoss;
    Location = location.copy();
    Velocity=startingVelocity.copy();
    Acceleration=new PVector();
    Mass=mass;
    MassLimit=massLimit;
    Force=force.copy();
    Size=mass*32;
  }

  void RenderParticle() {
    colorMode(HSB);
    stroke(HUE, 255, 255, Alpha);
    strokeWeight(Size);
    if (Mass>MassLimit) {
      Mass-=MassLoss;
    }
    if (Mass<MassLimit) {
      Mass=MassLimit;
    }
    Acceleration=Force.copy().mult(Mass);
    Velocity.add(Acceleration);
    Location.add(Velocity);
    point(Location.x, Location.y);
  }

  PVector GetLocation() {
    return Location.copy();
  }
  PVector GetVelocity() {
    return Velocity.copy();
  }
  PVector GetAcceleration() {
    return Acceleration.copy();
  }
  PVector GetForce() {
    return Force.copy();
  }
  float GetMass() {
    return Mass;
  }
  float GetHue() {
    return HUE;
  }
  float GetAlpha() {
    return Alpha;
  }
  void SetHue(float hue) {
    HUE=hue;
  }
  void SetAlpha(float alpha) {
    Alpha=alpha;
  }
}
