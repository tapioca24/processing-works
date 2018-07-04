PImage img;

void setup() {
  size(500, 500);
  noLoop();
  colorMode(RGB, 255, 255, 255, 100);

  img = loadImage("image.jpg");
  img.loadPixels();
}

void draw() {
  int bin = 25;
  float blockWidth = (float)width / bin;
  float blockHeight = (float)height / bin;

  for (int j = 0; j < bin; j++) {
    float ry = (float)j / bin;
    float y = ry * height;
    for (int i = 0; i < bin; i++) {
      float rx = (float)i / bin;
      float x = rx * width;

      // set color from image
      int imgX = (int)(rx * img.width);
      int imgY = (int)(ry * img.height);
      color col = img.pixels[imgY * img.width + imgX];
      drawBlock(x, y, blockWidth, blockHeight, col);
    }
  }
}

void drawBlock(float x, float y, float w, float h, color c) {
  float shadowRate = 0.06;

  // rect
  fill(c);
  stroke(0, 0, 0, 10);
  rect(x, y, w, h);

  // shadow
  fill(0, 0, 0, 40);
  noStroke();
  ellipse(x + w * (0.5 - shadowRate), y + h * (0.5 + shadowRate), w * 0.6, h * 0.6);
  
  // circle
  fill(c);
  noStroke();
  ellipse(x + w/2, y + h/2, w * 0.6, h * 0.6);
}

void keyPressed() {
  switch (key) {
    case 's':
      save("dist/image.jpg");
      break;
  }
}
