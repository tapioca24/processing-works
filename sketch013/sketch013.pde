Animator animator = new Animator();
color[] colors = new color[3];
float t;
String startTimestamp = String.valueOf(System.currentTimeMillis());
boolean saveImage = false;

void setup() {
  size(720, 720);
  animator.setup(30);
  animator.addState("translate", 1200);
  animator.addState("expand", 2100);
  colors[0] = #ff0000;
  colors[1] = #00ff00;
  colors[2] = #0000ff;
}

void draw() {
  AnimatorState state = animator.getCurrentState();
  float p = state.getPercentage();
  String name = state.getName();
  int frame = state.getFrame();
  int repeatCount = animator.getRepeatCount();

  t = easeInOutCubic(p);
  float from = name == "translate" ? 30 : 15;
  float to = name == "translate" ? 15 : 30;
  float dist = lerp(from, to, t);
  float R = dist * sqrt(3);
  float D = dist * 4 * sqrt(3);

  float r, shift;
  t = easeInOutCirc(p);
  if (name == "translate") {
    if (repeatCount % 2 == 0) {
      if (frame == 0) {
        blendMode(ADD);
      }
      background(0);
    } else {
      if (frame == 0) {
        blendMode(SUBTRACT);
      }
      background(255);
    }
    r = 0;
    shift = D * t;
  } else {
    if (repeatCount % 2 == 0) {
      background(0);
    } else {
      background(255);
    }
    r = dist * 4 * t;
    shift = 0;
  }

  translate(width / 2, height / 2);
  for (int j = -5; j <= 6; j++) {
    float y = D * j * sqrt(3) / 2;
    if (j % 2 == 0) {
      for (int i = -5; i <= 5; i++) {
        float x = D * i;
        drawDoughnuts(x, y, dist, R, r, shift);
      }
    } else {
      for (int i = -4; i <= 5; i++) {
        float x = D * i - D / 2;
        drawDoughnuts(x, y, dist, R, r, shift);
      }
    }
  }

  if (saveImage && repeatCount < 2) {
    saveFrame("dist/" + startTimestamp + "/sketch-####.png");
  }
}

void drawDoughnuts(float x, float y, float dist, float outerRadius, float innerRadius, float shift) {
  pushMatrix();
  translate(x, y);

  for (int i = 0; i < 3; i++) {
    float angle = (1 - (float)i / 3) * TWO_PI;
    pushMatrix();
    rotate(angle);
    translate(shift, 0);
    noStroke();
    fill(colors[i]);
    drawDoughnut(0, -dist, outerRadius, innerRadius);
    popMatrix();
  }

  popMatrix();
}

void drawDoughnut(float x, float y, float outerRadius, float innerRadius) {
  int resolution = 64;
  beginShape();
  for (int i = 0; i < resolution; i++) {
    float angle = (float)i / resolution * TWO_PI;
    vertex(x + outerRadius * cos(angle), y + outerRadius * sin(angle));
  }
  if (innerRadius > 0) {
    beginContour();
    for (int i = 0; i < resolution; i++) {
      float angle = (1 - (float)i / resolution) * TWO_PI;
      vertex(x + innerRadius * cos(angle), y + innerRadius * sin(angle));
    }
    endContour();
  }
  endShape(CLOSE);
}
