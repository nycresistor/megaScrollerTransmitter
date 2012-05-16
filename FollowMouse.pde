class FollowMouse extends Routine {
  int color_angle = 0;

  void draw() {
    background(0);
  
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        if(col > mouseX && row > mouseY) {
          stroke(255,0,0);
        }
        else if(col > mouseX && row < mouseY) {
          stroke(0,255,0);        
        }
        else if(col < mouseX && row > mouseY) {
          stroke(0,0,255);        
        }
        else if(col < mouseX && row < mouseY) {
          stroke(0,0,0);        
        }
        else {
          stroke(255,255,255);
        }
  //      stroke(0,0,2*((row+col+color_angle)%128));
        point(col,row);
      }
    }
    
    color_angle = (color_angle+1)%255;
  }


}
