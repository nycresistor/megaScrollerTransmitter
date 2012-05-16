class Target {
 float x;
 float y;
 float destx;
 float desty;
 float v;
 
 public Target() {
  this.reset(); 
 }
 
 public void reset() {
  destx = int(random(0, WIDTH));
  desty = int(random(0, HEIGHT));
  v = random(0.02, 0.07);
 }
 
 public void draw() {
  x = lerp(x, destx, v);
  y = lerp(y, desty, v);
  
  noStroke();
  fill(255);
  rect(int(x), 0, 1, HEIGHT);
  rect(0, int(y), WIDTH, 1);
  ellipse(int(x), int(y), 5, 5);
  
  fill(0);
  ellipse(int(x), int(y), 3, 3);
  
  if (abs(x - destx) < 1 || abs(y - desty) < 1) this.reset();

 }
}


