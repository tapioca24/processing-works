class Planet {
  float radius, theta;
  float speed;
  color strokeColor;
  float x, y;
  int canvasSize;
  
  Planet(float _radius, color _strokeColor, int _canvasSize, int fps) {
    radius = _radius;
    speed = 180 / (radius * fps);
    strokeColor = _strokeColor;
    canvasSize = _canvasSize;
  }

  void update() {
    theta += speed;
    if (theta > TWO_PI) {
      theta -= TWO_PI;
    }
    x = radius * cos(theta);
    y = radius * sin(theta);
  }
  
  void displayXY() {
    // circle
    stroke(strokeColor);
    strokeWeight(0.5);
    noFill();
    ellipseMode(CENTER);
    ellipse(0, 0, 2 * radius, 2 * radius);
    
    // point
    stroke(strokeColor);
    strokeWeight(12);
    point(x, y);
  }
  
  void displayThetaRho(float _strokeWeight, float _alpha) {
    int steps = 50;
    noFill();
    stroke(strokeColor, _alpha);
    strokeWeight(_strokeWeight);
    beginShape();
    for (int i = 0; i < steps; i++) {
      float theta = TWO_PI * i / (steps - 1) - PI;
      float rho = x * cos(theta) + y * sin(theta);
      vertex(
        map(theta, -PI, PI, -canvasSize/2, canvasSize/2),
        rho
      );
    }
    endShape();
  }
}
