class RainbowColors extends Routine {
  void draw() {
    long frame = frameCount - modeFrameStart;
  
  //  print(mouseY*255.0/height);
  //  print(" ");
    
    colorMode(HSB, 100);
    
    for(int x = 0; x < width; x++) {
      for(int y = 0; y < height; y++) {
        if (x < width/2) {
          stroke((pow(x,0.3)*pow(y,.8)+frame*0.25)%100,90,90);
        }
        else {
          stroke((pow(width-x,0.3)*pow(y,.8)+frame*0.25)%100,90,90);
        }
        point((x+frame*0.25)%width,y);
      }
    }
    
    colorMode(RGB, 255);
  }
}
