class OppositeLines extends Routine {
  void draw() {
    background(0);
    stroke(255);
  
    long frame = frameCount - modeFrameStart;
    int x = int(frame % 5);
  
    for (int i = x-5; i<WIDTH; i+=5) {
      line(i+8, 0, i, 8);
    }
  
    if (frame > FRAMERATE*5) {
      newMode();
    }
  }

}
