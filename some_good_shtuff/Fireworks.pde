class Fireworks { //<>//
  private ArrayList<Firework> Fireworks;
  private ArrayList<Firework> ToRemove;
  private final float Gravity;
  private final float Frequency;

  Fireworks(float frequency, float gravity) {
    Fireworks=new ArrayList<Firework>();
    ToRemove=new ArrayList<Firework>();
    Frequency=frequency;
    Gravity=gravity;
  }

  void RenderFireworks() {
    for (int i=0; i<10; i++) {
      if (random(0, 1)<=Frequency) { //<>//
        Fireworks.add(new Firework(new PVector(random(1, width-1), height), Gravity));
      }
    }    
    for (Firework Firework : Fireworks) {
      Firework.RenderFirework();
      if (Firework.Finished()) {
        ToRemove.add(Firework);
      }
    }
    if (!ToRemove.isEmpty()) {
      Fireworks.removeAll(ToRemove);
      ToRemove.clear();
    }
  }

  float GetGravity() {
    return Gravity;
  }
  float GetFrequency() {
    return Frequency;
  }
}
