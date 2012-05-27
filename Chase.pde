class Chase extends Routine {
  void draw() {
    background(0);
    stroke(255);
  
    long frame = frameCount - modeFrameStart;
    line(frame/3.0%width, 0, frame/3.0%width, height);
    line((frame/3.0+1)%width, 0, ((frame/3.0+1))%width, height);
    line((frame/3.0+2)%width, 0, ((frame/3.0+2))%width, height);
    line((frame/3.0+3)%width, 0, ((frame/3.0+3))%width, height);
  
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }

}
