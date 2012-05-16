class Flash extends Routine {
  void draw() {
    long frame = frameCount - modeFrameStart;
  
    if (frame % (2) < 1) {
      background(255,0,0);
    }
    else {
      background(0,255,255);
    }
  
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }

}
