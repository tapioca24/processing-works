color white = #ffffff;
color grey = #404137;
color green = #84CB29;

color bg, outline, box;

void setup() {
  size(720, 720);
  colorMode(HSB, 360, 100, 100);
  noLoop();
}

void draw() {
  float radius = random(30, 40);
  float alpha = random(0.2, 0.8);
  float gap = radius * random(3);
  float stepx = radius * sqrt(3) + gap;
  float stepy = stepx * sqrt(3) / 2;

  int numy = floor(height * 0.5 / stepy) + 1;
  int numx = floor(width * 0.5 / stepx) + 1;

  switch ((int)random(6)) {
    case 0: bg = white;  outline = grey;  box = green;  break;
    case 2: bg = grey;   outline = white; box = green;  break;
    case 3: bg = grey;   outline = green; box = white;  break;
    case 4: bg = green;  outline = white; box = grey;   break;
    case 5: bg = green;  outline = grey;  box = white;   break;
  }

  background(bg);
  
  noStroke();
  fill(outline);

  translate(width/2, height/2);
  for (int y = -numy; y <= numy; y++) {
    float pixy = y * stepy;
    int odd = (abs(y) % 2);    
    for (int x = -numx; x <= numx + odd; x++) {
      float pixx = x * stepx - odd * stepx / 2;
      pushMatrix();
      translate(pixx, pixy);
      drawHexagram(radius, alpha);
      popMatrix();
      
    }
  }
}

void drawHexagram(float radius, float alpha) {
  int rotateType = (int)random(6);
  int beginType = (int)random(3) - 1;
  int lenType = (int)random(2, 6);
  int endType = (int)random(3) - 1;
  float len = alpha * radius;
  
  if (random(1) < 0.95) {
    pushMatrix();
    rotate(TWO_PI / 6 * rotateType + TWO_PI / 12);
    beginShape();
    // begin
    if (beginType != -1) addCorner(0, len);
    addEdge(0, radius, alpha, beginType);
    if (beginType == -1) addCorner(0, radius);
    // go
    for (int i = 0; i < lenType; i++) {
      addCorner(i + 1, radius);
    }
    // end
    if (endType == 1) addCorner(lenType + 1, radius);
    addEdge(lenType + 1, radius, alpha, endType);
    if (endType != 1) addCorner(lenType + 1, len);
    // back
    for (int i = 0; i < lenType; i++) {
      addCorner(lenType - i, len);
    }
    endShape(CLOSE);
    
    // box
    if (random(1) < 0.7) {
      pushStyle();
      fill(box);
      drawHexagon(len * 0.7);
      popStyle();
    }
    
    popMatrix();
  } else {
    pushStyle();
    if (random(1) < 0.5) {
      fill(outline);
    } else {
      fill(box);
    }      
    pushMatrix();
    rotate(TWO_PI / 12);
    drawHexagon(radius);
    popMatrix();
    popStyle();
  }
}

void drawHexagon(float radius) {
  beginShape();
  for (int i = 0; i < 6; i++) {
    addCorner(i, radius);
  }
  endShape(CLOSE);  
}

void addEdge(int idx, float radius, float alpha, int type) {
  float len = alpha * radius;
  float angle1 = TWO_PI / 6 * (idx % 6);
  float angle2 = TWO_PI / 6 * ((idx + type) % 6);
  float x = len * cos(angle1) + (radius - len) * cos(angle2);
  float y = len * sin(angle1) + (radius - len) * sin(angle2);
  vertex(x, y);
}

void addCorner(int idx, float radius) {
  float angle = TWO_PI / 6 * (idx % 6);
  float x = radius * cos(angle);
  float y = radius * sin(angle);
  vertex(x, y);
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
