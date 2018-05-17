class MyBox {
  PVector pos;
  color col;
  color firstColor;
  float size;
  float len;
  
  boolean doEvent = false;
  PVector fromPos, toPos;
  PVector fromColor, toColor;
  int msec;
  long startTime;
  
  int transformCount;
  
  // routes[pattern][zone]
  int[][] routes = {
    { 2, 1, 0, 2, 0, 2, 2, 1 },
    { 0, 2, 2, 1, 2, 1, 0, 2 },
    { 1, 2, 2, 0, 2, 0, 1, 2 },
    { 2, 0, 1, 2, 1, 2, 2, 0 },
    { 1, 0, 2, 1, 0, 1, 1 ,2 },
    { 0, 1, 1, 2, 1, 0, 2, 1 },
    { 1, 0, 0, 1, 0, 2, 2, 0 },
    { 0, 1, 1, 0, 2, 0, 0, 2 },
    { 1, 2, 0, 1, 2, 1 ,1, 0 },
    { 2, 1, 1, 0, 1, 2, 0, 1 },
    { 2, 0, 0, 2, 0, 1, 1, 0 },
    { 0, 2, 2, 0, 1, 0, 0, 1 }
  };
  
  MyBox(color _col, float _size, float _len) {
    col = _col;
    firstColor = _col;
    size = _size;
    len = _len;
    transformCount = 0;
    resetPosition();
  }
  
  void resetPosition() {
    float z = random(-1, 1);
    float theta = random(TWO_PI);
    float r = random(1);
    
    float x = (float)Math.cbrt((double)r) * sqrt(1 - z * z) * cos(theta);
    float y = (float)Math.cbrt((double)r) * sqrt(1 - z * z) * sin(theta);
    z = (float)Math.cbrt((double)r) * z;
    
    pos = new PVector(x, y, z);
    pos.mult(len/2);
  }
  
  void update() {
    if (doEvent) {
      long currentTime = timestamp();
      int diff = (int)(currentTime - startTime);
      if (diff > msec) {
        doEvent = false;
        pos = PVector.add(fromPos, toPos);
      } else {
        float t = constrain((float)diff / msec, 0, 1);
        float r = easeInOutBack(t);
        pos = PVector.add(fromPos, toPos.copy().mult(r));
        PVector tmpColor = PVector.add(fromColor, toColor.copy().mult(r));
        col = color(tmpColor.x, tmpColor.y, tmpColor.z);
      }
    }
  }
  
  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    stroke(150);
    fill(col);
    box(size);
    popMatrix(); 
  }
 
  void setNext(PVector _toPos, color _toColor, int _msec) {
    if (transformCount++ % 8 == 7) {
      _toColor = firstColor;
    }
    
    // position
    fromPos = pos;
    toPos = _toPos;
    toPos.sub(fromPos);

    // color
    fromColor = new PVector(red(col), green(col), blue(col));
    toColor = new PVector(red(_toColor), green(_toColor), blue(_toColor));
    toColor.sub(fromColor);
    
    msec = _msec;
    startTime = timestamp();
    doEvent = true;
  }
  
  long timestamp(){
    return System.currentTimeMillis();
  }

  int zone() {
    int z = 0;
    if (pos.x <= 0) z += 4;
    if (pos.y <= 0) z += 2;
    if (pos.z <= 0) z++;
    return z;
  }
  
  float getValue(PVector vec, int origin) {
    float value = 0;
    switch (origin) {
      case 0: value = vec.x; break;
      case 1: value = vec.y; break;
      case 2: value = vec.z; break;
    }
    return value;
  }
  
  void setValue(PVector vec, int origin, float value) {
    switch (origin) {
      case 0: vec.x = value; break;
      case 1: vec.y = value; break;
      case 2: vec.z = value; break;
    }
  }
  
  PVector getNewPos(int pattern) {
    int direction = routes[pattern][zone()];
    PVector result = pos.copy();
    float value = getValue(result, direction);
    value += value > 0 ? -len/2 : len/2;
    setValue(result, direction, value);
    return result;
  }
}
