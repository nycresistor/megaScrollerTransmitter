class Stars extends Routine {
  int NUMBER_OF_STARS = 30;
  Star[] stars;

  void setup(PApplet parent) {
    super.setup(parent);
    stars = new Star[NUMBER_OF_STARS];
    for (int i=0; i<NUMBER_OF_STARS; i++) {
      stars[i] = new Star(i*1.0/NUMBER_OF_STARS*ZOOM);
    }
  }
  
  void draw() {
    background(0);
    
    for (int i=0; i<NUMBER_OF_STARS; i++) {
      stars[i].draw();
    }
    
    if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }

}

