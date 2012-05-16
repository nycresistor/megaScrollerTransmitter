class Lines extends Routine {
  void draw() {
    background(0);
    stroke(255);
  
    long frame = frameCount - modeFrameStart;
    int x = int(frame % 5);
  
    for (int i = -x; i<WIDTH; i+=5) {
      line(i, 0, i+8, 8);
    }
  
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }

}
