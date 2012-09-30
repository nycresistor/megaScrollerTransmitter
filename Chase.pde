class Chase extends Routine {
  void draw() {
    background(0);
    stroke(color(255,255,255));

    long frame = frameCount - modeFrameStart;
    line(frame/3.0%displayWidth, 0, frame/3.0%displayWidth, displayHeight);
    line((frame/3.0+1)%displayWidth, 0, ((frame/3.0+1))%displayWidth, displayHeight);

    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}

