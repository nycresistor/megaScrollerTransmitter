class Waterfall {
  float x;
  float y;
  float len;
  float v;
  
  public Waterfall() {
    this.reset(); 
  }
  
  public void reset() {
    x = int(random(0, WIDTH));
    y = -1;
    len = random(1, 5);
    v = random(0.1, 1);
  }
  
  public void draw() {
    y = y + v; 
        
    rect(x, y, 0.1, len);
    if (y > HEIGHT) this.reset();
    
  }
}


