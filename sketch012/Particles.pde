class Particles {
  int maxSize;
  ArrayList<Particle> particles;
  
  Particles() {
    maxSize = 5000;
    particles = new ArrayList<Particle>();
  }
  
  void update() {
    remove();
    add();
    for (Particle p: particles) {
      p.update();
    }
  }
  
  void draw() {
    for (Particle p: particles) {
      p.draw();
    }
  }
  
  void remove() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
  void add() {
    while (particles.size() < maxSize) {
      particles.add(new Particle());
    }
  }
  
  void clear() {
    particles.clear();
  }
}
