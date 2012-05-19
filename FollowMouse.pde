class FollowMouse extends Routine {
  int color_angle = 0;
  color[] colors = new color[] { color(255,0,0), color(0,255,0), color(0,0,255), color(255,255,0) };

  void buttonAPressed() {
    color tmp = colors[0];
    colors[0] = colors[1];
    colors[1] = colors[2];
    colors[2] = colors[3];
    colors[3] = tmp;
  }
  
  void draw() {
    background(0);
  
    int x = int((controller.roll+90)/180*width);
    int y = int((controller.pitch+90)/180*height);
    
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        if(col > x && row > y) {
          stroke(colors[0]);
        }
        else if(col > x && row < y) {
          stroke(colors[1]);
        }
        else if(col < x && row > y) {
          stroke(colors[2]);     
        }
        else if(col < x && row < y) {
          stroke(colors[3]);
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
