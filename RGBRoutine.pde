class RGBRoutine extends Routine {
  int color_angle = 0;
  
  void draw() {
    background(0);
  
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        stroke(0,2*((row+col+color_angle)%128),0);
        point(col,row);
      }
    }
    
    color_angle = (color_angle+1)%255;
  }
}
