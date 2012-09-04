class RainbowColors extends Routine {
  void draw() {
    long frame = frameCount - modeFrameStart;
  
  //  print(mouseY*255.0/height);
  //  print(" ");
    
    colorMode(HSB, 100);
    
    for(int x = 0; x < width; x++) {
      for(int y = 0; y < height; y++) {
        if (x < width/2) {
          stroke((pow(x,0.3)*pow(y,.8)+frame)%100,90*random(.2,1.8),90*random(.5,1.5));
        }
        else {
          stroke((pow(width-x,0.3)*pow(y,.8)+frame)%100,90*random(.2,1.8),90*random(.5,1.5));
        }
        point((x+frame)%width,y);
      }
    }
    
    colorMode(RGB, 255);
       
    if (frame > FRAMERATE*TYPICAL_MODE_TIME) {
      newMode();
    }
  }
}
