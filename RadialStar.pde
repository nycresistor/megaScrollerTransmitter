class RadialStar {
  float x;
  float y;
  float theta;
  float v;
 
 public RadialStar() {
   this.reset();
 }
 
 public void draw() {
   x = x + (v * cos(theta));
   y = y + (v * sin(theta));
   
   noStroke();
   fill(255);
   rect(x, y, 1, 1);
   
   if ((x > WIDTH || x < 0) || (y > HEIGHT || y < 0)) this.reset();
   
 }
 
 public void reset() {
    x = 7;
    y = 7;
    theta = random(0, 2 * PI);
    v = random(0.05, 1);
 }

}


