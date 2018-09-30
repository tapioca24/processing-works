/*
 * Please download the font from the following URL and store it in the "data" directory before running it.
 * https://fonts.google.com/specimen/Nunito
 */

PGraphics pg;
color textColor = #ffffff;
color pgColor = #000000;
color bgColor = #000000;
PFont fontLight, fontBold;
Particles particles;

// noise parameters
float nstep;
PVector noffset;
float angleOffset;
float angleVariability;
float hstep;
PVector hoffset;
float hueOffset;
float hueVariability;

String startTimestamp = timestamp();

void setup() {
  size(720, 720);
  frameRate(60);
  smooth(16);
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(ADD);
  
  // text styling
  fontLight = createFont("Nunito-Regular.ttf", 32);
  fontBold = createFont("Nunito-Black.ttf", 32);
  textAlign(CENTER, CENTER);
  fill(textColor);
  
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.textFont(fontBold);
  pg.textSize(320);
  pg.textAlign(CENTER, CENTER);
  pg.fill(pgColor);
  pg.text("300", pg.width * 0.5, pg.height * 0.441);
  pg.endDraw();

  particles = new Particles();
  init();
}

void init() {
  // randomize parameters
  nstep = 0.01;
  noffset = new PVector(random(1000), random(1000));
  angleVariability = random(1.3, 2.2);
  angleOffset = random(TWO_PI);

  hstep = 0.005;
  hoffset = new PVector(random(1000), random(1000));
  hueVariability = random(50, 100);
  hueOffset = random(360);

  background(#000000);
  
  particles.clear();
  
  textFont(fontBold);
  textSize(42);
  textSpaced("THANKS", width * 0.5, height * 0.23, 15);
  textFont(fontLight);
  textSize(28);
  textSpaced("FOLLOWERS", width * 0.5, height * 0.82, 40);
}

void draw() {
  particles.update();
  particles.draw();
  
  //saveFrame("dist/" + startTimestamp + "/sketch-####.png");
}

void mousePressed() {
  init();
}

void keyPressed() {
  if (key == 's') {
    save("dist/sketch-" + timestamp() + ".png");
  }
}

void textSpaced(String str, float x, float y, float space) {
  pushStyle();
  textAlign(CENTER);
  float len = 0;
  for (int i = 0; i < str.length(); i++) {
    char c = str.charAt(i);
    float w = textWidth(c);
    len += (i == 0) ? w : w + space;
  }

  pushMatrix();
  translate(x - len / 2, y);
  len = 0;
  for (int i = 0; i < str.length(); i++) {
    char c = str.charAt(i);
    float w = textWidth(c);
    len += (i == 0) ? w/2 : w/2 + space;
    text(c, len, 0);
    len += w/2;
  }
  popMatrix();
  popStyle();
}

String timestamp() {
  return String.valueOf(System.currentTimeMillis());
}
