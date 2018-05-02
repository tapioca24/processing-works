Planet[] planets;
int canvasSize;
int num = 12;
int fps = 60;
boolean useMotionBlur = true;
boolean useSaveFrame = false;
String startTimestamp = timestamp();

void setup() {
  size(1000, 500);
  canvasSize = height;
  frameRate(fps);
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);

  // init planets
  planets = new Planet[num];
  for (int i = 0; i < num; i++) {
    int hue = (50 + i * 343) % 360;
    color col = color(hue, 60, 90);
    planets[i] = new Planet(canvasSize * (i + 1) / (2.0 * (num + 1)), col, canvasSize, fps);
  }
}

void draw() {
  // update
  for (Planet planet : planets) {
    planet.update();
  }
  
  // left side : x-y space
  pushMatrix();
  translate(canvasSize/2, canvasSize/2);
  // background
  noStroke();
  fill(#FFFEDE);
  rect(0, 0, canvasSize, canvasSize);
  // planets
  rotate(radians(90));
  scale(-1, 1);
  for (Planet planet : planets) {
    planet.displayXY();
  }
  popMatrix();

  // right side : theta - rho space
  pushMatrix();
  translate(canvasSize + canvasSize/2, canvasSize/2);
  // background
  noStroke();
  if (useMotionBlur) {
    fill(#1E2B4D, frameCount == 1 ? 100 : 8);
  } else {
    fill(#1E2B4D);
  }
  rect(0, 0, canvasSize, canvasSize);
  // planets
  for (Planet planet : planets) {
    planet.displayThetaRho(8, 20);
    planet.displayThetaRho(2, 100);
  }
  popMatrix();

  if (useSaveFrame) {
    saveFrame("dist/" + startTimestamp + "/sketch-####");
  }
}

String timestamp() {
  return String.valueOf(System.currentTimeMillis());
}
