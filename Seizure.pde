class Seizure extends Routine {
  int count = 0;
  
  void draw() {
    long frame = frameCount - modeFrameStart;
  
    if (count == 0) {
      background(0,0,0);
    }
    else {
      background(255,255,255);
    }
    
    count = (count + 1) % 2;
  
//    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
//      newMode();
//    }
  }
}
