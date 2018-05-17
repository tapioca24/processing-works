import com.cage.colorharmony.*;

ColorHarmony ch = new ColorHarmony(this);
color[] colors = new color[8];
String baseColorHex;

int len = 380;
int boxNum = 3000;
MyBox[] boxes = new MyBox[boxNum];

int fps = 60;
boolean saveFlag = false;
String dir = String.valueOf(System.currentTimeMillis());

void setup() {
  size(720, 720, P3D);
  blendMode(DARKEST);
  frameRate(fps);
  resetColors();
  
  for (int i = 0; i < boxNum; i++) {
    color c = colors[(int)random(4)];
    float size = len * random(2, 4) / 100;
    boxes[i] = new MyBox(c, size, len);
  }
}

void draw() {
  if (frameCount % fps == 0) {
    transform();
  }
  
  for (MyBox b : boxes) {
    b.update();
  }

  background(215, 225, 235);
  translate(width/2, height/2);
  rotateX(-HALF_PI * 0.25);
  rotateY(TWO_PI / 8 * frameCount / fps - TWO_PI / 32 * 11);
  for (MyBox b : boxes) {
    b.display();
  }
  
  if (saveFlag) {
    saveFrame("dist/" + dir + "/sketch-####.png");
  }
}

void transform() {
  resetColors();

  int pattern = 1;//(int)random(12);

  for (MyBox b : boxes) {
    color newColor = colors[(int)random(4)];
    PVector newPos = b.getNewPos(pattern);
    b.setNext(newPos, newColor, 500);
  }
}

void keyPressed() {
  if (key == 's') {
    save("dist/" + String.valueOf(System.currentTimeMillis()) + ".png");
  } else {
    transform();
  }
}

void resetColors(){
  float h = random(360);
  float s = random(60, 80);
  float l = random(80, 95);
  baseColorHex = ch.HSL2Hex(h, s, l);
  int type = (int)random(4);
  switch (type) {
    case 0: colors = ch.Monochromatic(baseColorHex); break;
    case 1: colors = ch.Analogous(baseColorHex); break;
    case 2: colors = ch.Complementary(baseColorHex); break;
    case 3: colors = ch.Triads(baseColorHex); break;
  }
}
