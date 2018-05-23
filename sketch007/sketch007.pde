int colorNum = 3;
color[] colors = new color[colorNum];

void setup() {
  size(720, 720);
  noLoop();
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() {
  switch ((int)random(10)) {
    case 0: blendMode(BLEND);       background(#F5EBE1);  break;
    case 1: blendMode(ADD);         background(#141E28);  break;
    case 2: blendMode(SUBTRACT);    background(#F5EBE1);  break;
    case 3: blendMode(SUBTRACT);    background(#F5EBE1);  break;
    case 4: blendMode(LIGHTEST);    background(#141E28);  break;
    case 5: blendMode(DIFFERENCE);  background(#F5EBE1);  break;
    case 6: blendMode(EXCLUSION);   background(#F5EBE1);  break;
    case 7: blendMode(MULTIPLY);    background(#F5EBE1);  break;
    case 8: blendMode(SCREEN);      background(#141E28);  break;
    case 9: blendMode(REPLACE);     background(#141E28);  break;
  }

  int div = (int)random(4, 15) * 2;
  float step = width / (float)div;
  float diagonal = step / sqrt(2);
  float diagonalRatio = random(0.5, 2.0);
  strokeWeight(diagonal * diagonalRatio);
  float lineThresh = random(0.1, 0.9);
  switch ((int)random(2)) {
    case 0: strokeCap(ROUND); break;
    case 1: strokeCap(PROJECT); break;
  }

  float h = random(360);
  float hstep = random(20, 160);
  for (int i = 0; i < colorNum; i++) {
    float s = 70;
    float b = 90;
    colors[i] = color((h + hstep * i) % 360, s, b);
  }

  float lengthMin = (int)random(1, 4);
  float lengthMax = lengthMin + (int)random(8);
  
  for (int y = 0; y < div * 2; y++) {
    float pixy = y * step / 2 + step / 4;
    for (int x = 0; x < div; x++) {
      float pixx = (x + (y % 2) * 0.5) * step + step / 4;
      if (random(1) < lineThresh) {
        pushMatrix();
        translate(pixx, pixy);
        float angle = QUARTER_PI + (int)random(4) * HALF_PI;
        rotate(angle);
        stroke(colors[(int)random(colors.length)], 40);
        line(0, 0, 0, diagonal * (int)random(lengthMin, lengthMax));
        popMatrix();
      }
    }
  } 
}

void keyPressed() {
  switch (key) {
    case 'r':
      redraw();
      break;
    case 's':
      save("dist/" + String.valueOf(System.currentTimeMillis()) + ".png");
      break;
  }
}
