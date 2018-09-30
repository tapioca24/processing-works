class Particle {
  PVector pos;
  int life, age;
  color col;

  Particle() {
    initPosition();
    life = (int)random(10, 50);
    age = life;
  }

  void initPosition() {
    while (pos == null || !isInText(pos)) {
      pos = new PVector(random(width), random(height));
    }
  }

  boolean isInText(PVector v) {
    return pg.get(int(v.x), int(v.y)) == pgColor;
  }

  boolean isDead() {
    return age < 0;
  }

  void update() {
    // update position
    float angle = noise(
      pos.x * nstep + noffset.x,
      pos.y * nstep + noffset.y,
      frameCount * 0.001
    ) * TWO_PI * angleVariability + angleOffset;
    PVector vel = PVector.fromAngle(angle);
    pos.add(vel);

    // update color
    float hue = (2 * noise(pos.x * hstep + hoffset.x, pos.y * hstep + hoffset.y) - 1) * hueVariability;
    hue = (hue + 360 + hueOffset) % 360;
    float sat = 60;
    float bri = 90;
    float alpha = (float)age / life * 20;
    col = color(hue, sat, bri, alpha);

    // update age
    age--;
  }

  void draw() {
    strokeWeight(0.75);
    stroke(col);
    point(pos.x, pos.y);
  }
}
