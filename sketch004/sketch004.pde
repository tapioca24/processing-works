PVector offsets = new PVector(1.23, 1.23, 7.89);
PVector steps = new PVector(0.008, 0.008, 0.056);
int currentHue, targetHue;
int blockSize;
int interval = 20;
float [] noisex, noisey;
boolean saveFlag = false;
String startTimestamp = String.valueOf(System.currentTimeMillis());

void setup() {
  size(500, 500);
  frameRate(30);
  colorMode(HSB, 360, 100, 100);
  noStroke();

  noisex = new float[width];
  noisey = new float[height];
  reset();
  currentHue = targetHue;
}

void reset() {
  blockSize = int(pow(2, floor(random(1, 4))));
  targetHue = int(random(360));
}

void update() {
  if ((frameCount + 5) % interval == 0) {
    reset();
  }
  
  // update hue
  int diff = targetHue - currentHue;
  if (diff != 0) {
    if (abs(diff) < 2) {
      currentHue = targetHue;
    } else {
      if (180 < diff) {
        diff -= 360;
      } else if (diff < -180) {
        diff += 360;
      }
      currentHue += int(diff * 0.3);
      if (currentHue < 0) {
        currentHue += 360;
      } else if (360 < currentHue) {
        currentHue -= 360;
      }
    }
  }
  
  // update noise
  float timeFactor = 0.3 * cos(TWO_PI / interval * frameCount);
  for (int i = 0; i < width; i++) {
    noisex[i] = noise(
      offsets.x + i * steps.x,
      offsets.z + frameCount * steps.z + timeFactor
    );
  }
  for (int i = 0; i < height; i++) {
    noisey[i] = noise(
      offsets.y + i * steps.y,
      offsets.z + frameCount * steps.z + timeFactor
    );
  }
}

void draw() {
  update();  
  background(0);
  for (int y = 0; y < height; y += blockSize) {
    for (int x = 0; x < width; x += blockSize) {
      drawPoint(x, y, noisex[x] * noisey[y]);
    }
  }
  
  if (saveFlag) {
    saveFrame("dist/" + startTimestamp + "/sketch-####");
  }
}

void drawPoint(float x, float y, float factor) {
  pushMatrix();
  translate(x, y);
  float thresh = 0.15;
  float brightness = (factor < thresh) ? 0 : lerp(0, 90, 5 * (factor - thresh));
  fill(currentHue, 60, brightness);
  rect(0, 0, blockSize, blockSize);  
  popMatrix();
}
