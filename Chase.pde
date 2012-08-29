class Chase extends Routine {
  void draw() {

    // naim hack (PORNJ Pink: RGB 252/23/218) 
    float r = random(220,255)/2;
    float g = random(0,55)/2;
    float b = random(210,230)/2;
    background(0);
    stroke(color(r,g,b));
  
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
