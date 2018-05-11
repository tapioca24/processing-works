class MyBox {
  PVector pos;
  color col;
  float size;
  float len;
  
  boolean doEvent = false;
  PVector fromPos, toPos;
  PVector fromColor, toColor;
  int msec;
  long startTime;
  
  MyBox(color _col, float _size, float _len) {
    col = _col;
    size = _size;
    len = _len;
    resetPosition();
  }
  
  void resetPosition() {
    float x = random(-len/2, len/2);
    float y = random(-len/2, len/2);
    float z = random(-len/2, len/2);
    pos = new PVector(x, y, z);
  }
  
  void update() {
    if (doEvent) {
      long currentTime = timestamp();
      int diff = (int)(currentTime - startTime);
      if (diff > msec) {
        doEvent = false;
      } else {
        float t = constrain((float)diff / msec, 0, 1);
        float r = easeOutElastic(t);
        pos = PVector.add(fromPos, toPos.copy().mult(r));
        PVector tmpColor = PVector.add(fromColor, toColor.copy().mult(r));
        col = color(tmpColor.x, tmpColor.y, tmpColor.z);
      }
    }
  }
  
  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    stroke(255, 50);
    fill(col);
    box(size);
    popMatrix(); 
  }
  
  void setColor(color _col) {
    col = _col;
  }
  
  void setNext(PVector _toPos, color _toColor, int _msec) {
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
}
