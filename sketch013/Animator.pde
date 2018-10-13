class Animator {
  private int fps = 60;
  private ArrayList<AnimatorState> stateList = new ArrayList<AnimatorState>();
  private ArrayList<Integer> sumFrames = new ArrayList<Integer>();

  void setup(int fps) {
    this.fps = fps;
    frameRate(this.fps);
  }

  void addState(String name, int duration /* [msec] */ ) {
    int stateFrames = duration * this.fps / 1000;
    this.stateList.add(new AnimatorState(name, stateFrames));
    this.sumFrames.add(this.getTotalFrames() + stateFrames);
  }
  
  int getTotalFrames() {
    return this.sumFrames.size() > 0 ? this.sumFrames.get(this.sumFrames.size() - 1) : 0;
  }

  int getRepeatCount() {
    return this.getTotalFrames() > 0 ? (frameCount - 1) / this.getTotalFrames() : 0;
  }

  int getFrame() {
    return this.getTotalFrames() > 0 ? (frameCount - 1) % this.getTotalFrames() : 0;
  }

  float getPercentage() {
    return this.getTotalFrames() > 1 ? (float)this.getFrame() / (this.getTotalFrames() - 1) : 0;
  }

  AnimatorState getCurrentState() {
    if (this.getTotalFrames() == 0) { return null; }

    int frame = this.getFrame();
    int i;
    for (i = 0; i < this.sumFrames.size(); i++) {
      if (frame < this.sumFrames.get(i)) {
        break;
      }
    }
    if (i > 0) {
      frame -= this.sumFrames.get(i - 1);
    }
    AnimatorState state = this.stateList.get(i);
    state.setFrame(frame);
    return state;
  }
}

class AnimatorState {
  private String name;
  private int totalFrames = 0;
  private int frame = 0;
  
  AnimatorState(String name, int totalFrames) {
    this.name = name;
    this.totalFrames = totalFrames;
  }
  
  String getName() {
    return this.name;
  }
    
  int getFrame() {
    return this.frame;
  }
  
  int getTotalFrames() {
    return this.totalFrames;
  }
  
  float getPercentage() {
    return this.totalFrames > 1 ? (float)this.frame / (this.totalFrames - 1) : 0;
  }
  
  private void setFrame(int frame) {
    if (frame < this.totalFrames) {
      this.frame = frame;
    }
  }
}
