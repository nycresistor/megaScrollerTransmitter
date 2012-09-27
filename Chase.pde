class Chase extends Routine {
  void draw() {

    // naim hack (PORNJ Pink: RGB 252/23/218) 
    float r = random(220, 255)/2;
    float g = random(0, 55)/2;
    float b = random(210, 230)/2;
    background(0);
    stroke(color(r, g, b));

    long frame = frameCount - modeFrameStart;
    line(frame/3.0%displayWidth, 0, frame/3.0%displayWidth, displayHeight);
    line((frame/3.0+1)%displayWidth, 0, ((frame/3.0+1))%displayWidth, displayHeight);
    line((frame/3.0+2)%displayWidth, 0, ((frame/3.0+2))%displayWidth, displayHeight);
    line((frame/3.0+3)%displayWidth, 0, ((frame/3.0+3))%displayWidth, displayHeight);

    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

