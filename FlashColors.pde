class FlashColors extends Routine {
  void draw() {
    long frame = frameCount - modeFrameStart;
  
  //  print(mouseY*255.0/height);
  //  print(" ");
    
    colorMode(HSB, 100);
    
    for(int x = 0; x < width; x++) {
      for(int y = 0; y < height; y++) {
        stroke((x*y+frame*4)%100,90,90);
        point(x,y);
      }
    }
    
    colorMode(RGB, 255);
  }
}
