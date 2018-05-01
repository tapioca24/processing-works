color colors[] = new color[4];

void setup() {
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
  ellipseMode(CENTER);
  noStroke();
  init();
}

void draw() {
  background(209, 60, 25);
  int padding = 20;
  int div = 5;
  float gap = float(width - 2 * padding) / div;
  float radius = gap * 0.8;

  for (int y = 0; y < div; y++) {
    float ry = y / float(div - 1);
    color c1 = lerpColor(colors[0], colors[1], ry);
    color c2 = lerpColor(colors[2], colors[3], ry);
    for (int x = 0; x < div; x++) {
      float rx = x / float(div - 1);
      color inter = lerpColor(c1, c2, rx);
      fill(inter);
      ellipse(padding + x * gap + gap/2, padding + y * gap + gap/2, radius, radius);
    }
  }
}

void init() {
  float saturation = random(50, 70);
  float offset = random(360);
  for (int i = 0; i < colors.length; i++) {
    int hue = int(offset + random(30, 180)) % 360;
    colors[i] = color(hue, saturation, 90);
  }
}

void keyPressed() {
  if (key == 's') {
    save("dist/sketch-" + timestamp() + ".png");
  } else if (key == 'r') {
    init();
  }
}

String timestamp() {
  return String.valueOf(System.currentTimeMillis());
}
