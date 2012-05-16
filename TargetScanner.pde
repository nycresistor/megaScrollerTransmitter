class TargetScanner extends Routine {
  Target targetScanner;
  
  void setup(PApplet parent) {
    super.setup(parent);
    targetScanner = new Target();
  }
  
  void draw() {
    background(0);
  
    targetScanner.draw();
    
   if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }

}
