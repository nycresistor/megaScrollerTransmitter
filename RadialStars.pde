class RadialStars extends Routine {
  int NUMBER_OF_STARS = 30;
  RadialStar[] radialStars;

  void setup(PApplet parent) {
    super.setup(parent);
    radialStars = new RadialStar[NUMBER_OF_STARS];
    for (int i=0; i<NUMBER_OF_STARS; i++) {
      radialStars[i] = new RadialStar(); 
    }
  }
  
  void draw() {
    background(0);
   
    for (int i=0; i<NUMBER_OF_STARS; i++) {
      radialStars[i].draw();
    }
   
   if (frameCount - modeFrameStart > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

