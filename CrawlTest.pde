class CrawlTest extends Routine {
  int y;
  int x;
  
  void setup() {
    y=0;
    x=0;
  }
  
  void draw() {
    background(0);
  
    if (frameCount % 4 == 0) { 
      x++;
    }
    if (x>width) {
      x=0;
      y++;
      
      if (y>height) {
        y=0;
      }
    }
    
    stroke(255);
    point(x,y);
  }
}

