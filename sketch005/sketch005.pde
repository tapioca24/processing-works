import com.cage.colorharmony.*;

ColorHarmony ch = new ColorHarmony(this);
color[] colors = new color[8];
String baseColorHex;

int len = 300;
int boxNum = 300;
MyBox[] boxes = new MyBox[boxNum];

int fps = 30;
boolean saveFlag = false;
String dir = String.valueOf(System.currentTimeMillis());

void setup() {
  size(720, 720, P3D);
  frameRate(fps);
  resetColors();
  
  for (int i = 0; i < boxNum; i++) {
    color c = colors[(int)random(4)];
    float size = random(22.5, 45);
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

  background(30, 40, 50);
  translate(width/2, height/2);
  rotateY(frameCount * 0.01);
  for (MyBox b : boxes) {
    b.display();
  }
  
  if (saveFlag) {
    saveFrame("dist/" + dir + "/sketch-####");
  }
}

void transform() {
  resetColors();
  for (MyBox b : boxes) {
    color newColor = colors[(int)random(4)];
    PVector newPos = b.pos.copy();
    int pattern = (int)random(3);
    switch (pattern) {
      case 0: newPos.x *= -1; break;
      case 1: newPos.y *= -1; break;
      case 2: newPos.z *= -1; break;
    }
    b.setNext(newPos, newColor, 500);
  }  
}

void keyPressed() {
  transform();
}

void resetColors(){
  float h = random(360);
  float s = random(50, 70);
  float l = random(80, 99);
  baseColorHex = ch.HSL2Hex(h, s, l);
  int type = (int)random(4);
  switch (type) {
    case 0: colors = ch.Monochromatic(baseColorHex); break;
    case 1: colors = ch.Analogous(baseColorHex); break;
    case 2: colors = ch.Complementary(baseColorHex); break;
    case 3: colors = ch.Triads(baseColorHex); break;
  }
}
