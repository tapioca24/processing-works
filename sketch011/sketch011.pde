PGraphics screen;
color bg;
color colors[] = new color[4];
float fps = 60;
float stepTime = 800; // msec
float intervalCount = 3 * stepTime / 1000 * fps;
Boolean bSave = false;
String startTime;

void setup() {
  size(500, 500);
  frameRate(fps);
  
  colorMode(HSB, 360, 100, 100, 100);
  bg = color(#F4FBFB);
  colors[0] = color(#63c2a1, 75);
  colors[1] = color(#95d3db, 75);
  colors[2] = color(#ebae3b, 75);
  colors[3] = color(#dc194d, 75);
  
  screen = createGraphics(500, 500);
  
  startTime = timestamp();
}

void draw() {
  float D = 320;
  float d = D * 0.55;
  float weight = 100;
  
  screen.beginDraw();
  screen.blendMode(MULTIPLY);
  screen.colorMode(HSB, 360, 100, 100, 100);
  screen.background(bg);
  screen.translate(screen.width/2, screen.height/2);
  screen.strokeWeight(weight);

  for (int i = 0; i < 4; i++) {
    color c = colors[i];
    screen.pushMatrix();
    screen.stroke(c);
    screen.rotate(i * HALF_PI - PI * 19 / 180);

    float count = frameCount % intervalCount;
    float timeRate = count / intervalCount;
    if (timeRate < 1.0 / 3) {
      float t = map(timeRate, 0, 1.0/3, 0, 1);
      float y = lerp(-D/2, D/2, easeInOutCirc(t));
      screen.line(-d/2, -D/2, -d/2, y);
    } else if (timeRate < 2.0 / 3) {
      float t = map(timeRate, 1.0/3, 2.0/3, 0, 1);
      float y = lerp(-D/2, D/2, easeInOutCirc(t));
      screen.line(-d/2, y, -d/2, D/2);
    } else {
      float t = map(timeRate, 2.0/3, 1, 0, 1);
      float y = lerp(D/2, -D/2, easeInOutCirc(t));
      screen.line(-d/2, y, -d/2, y);
    }
 
    screen.popMatrix();
  }

  screen.endDraw();
  
  image2Block(screen);
  //image(screen, 0, 0);
  
  if (bSave) {
    save("dist/" + startTime + "/" + timestamp() + ".jpg");
  }
}

void image2Block(PImage img) {
  int bin = 24;
  float blockWidth = (float)width / bin;
  float blockHeight = (float)height / bin;

  for (int j = 0; j < bin; j++) {
    float y = (float)j / bin * height;
    for (int i = 0; i < bin; i++) {
      float x = (float)i / bin * width;

      // set color from image
      int imgX = (int)((float)(i + 0.5) / bin * img.width);
      int imgY = (int)((float)(j + 0.5) / bin * img.height);
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

String timestamp() {
  return String.valueOf(System.currentTimeMillis());
}
