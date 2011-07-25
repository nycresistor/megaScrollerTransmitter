/**
* Greetz for the DACWES!
*/

import hypermedia.net.*;

String messages[] = new String[] {
  "DISORIENT",
  "KOSTUME  KULT",
  "BLACK  LIGHT  BALL"
};
  
String hostname = "127.0.0.1"; //"192.168.1.130";
String message = "DISORIENT";

int WIDTH = 16;
int HEIGHT = 8;
boolean VERTICAL = false;

int FRAMERATE = 30;

int w = -((message.length()-1) * 10 + WIDTH);
int x = WIDTH;
PFont font;
int ZOOM = 1;
int NUMBER_OF_STARS = 30;
Star[] stars;

int NUMBER_OF_BURSTS = 4;
Burst[] bursts;

byte[] buffer;
UDP udp;
long modeFrameStart;

int modes = 10;
int mode = 0;
boolean burst_fill = false;

int direction = 1;
int position = 0;

void setup() {
  size(WIDTH,HEIGHT);
  
  font = loadFont("Disorient-8.vlw");
  textFont(font,9);
  textMode(SCREEN);
  frameRate(FRAMERATE);
  
  stars = new Star[NUMBER_OF_STARS];
  for (int i=0; i<NUMBER_OF_STARS; i++) {
    stars[i] = new Star(i*1.0/NUMBER_OF_STARS*ZOOM);
  }
  
  bursts = new Burst[NUMBER_OF_BURSTS];
  for (int i = 0; i<NUMBER_OF_BURSTS; i++) {
    bursts[i] = new Burst();
  }
  
  // init transmit buffer
  buffer = new byte[257];
  buffer[0] = 1;
  for (int i =  1; i < 257; i++)
    buffer[i] = 0;
  
  udp = new UDP(this);
  //newMode();
  
  smooth();
}

void newMode() {
  mode = mode == 1 ? 0 : 1;
  println("New mode " + mode);
  
  if (mode == 0)
    println("Scrolling " + message);
  else if (mode == 1)
    burst_fill = boolean(int(random(1)+0.5));

  /*
  int oldMode = mode;
  while (mode == oldMode) {
    mode = int(random(modes));
  }*/

  modeFrameStart = frameCount;
}

void draw() {
  if (mode == 0) {
    drawGreetz();
  }
  else if (mode == 1) {
    drawBursts();
  }
  else if (mode == 2) {
    drawFlash();
  }
  else if (mode == 3) {
    drawLines();
  }
  else if (mode == 4) {
    drawFader();
  }
  else if (mode == 5)
    drawCurtain();
  else if (mode == 6)
    drawVertLine();
  else if (mode == 7)
    drawSticks();
  else if (mode == 8)
    drawLinesTheOtherWay();
  else if (mode == 9)
   drawSpin();
}

void drawGreetz() {
  background(0);
  fill(255);

  text(message,x,8);

  x = x - 1;
  if (x<w) {
    x = WIDTH;  
    message = messages[int(random(messages.length))];
    w = -((message.length()-1) * 10 + WIDTH);
    newMode();
  }
  
  sendDataGreetz();
}

void drawBursts()
{
//  background(0);
  
  for (int i=0; i<NUMBER_OF_BURSTS; i++) {
    bursts[i].draw(burst_fill);
  }

  if (frameCount - modeFrameStart > FRAMERATE*60) {
    newMode();
  }
  
  sendData();
}


void drawStars() {
  background(0);
  
  for (int i=0; i<NUMBER_OF_STARS; i++) {
    stars[i].draw();
  }
  
  if (frameCount - modeFrameStart > FRAMERATE*10) {
    newMode();
  }
  
  sendData();
}

void drawFlash() {
  long frame = frameCount - modeFrameStart;
  
  if (frame % (FRAMERATE/5) < 1) {
    background(255);
  }
  else {
    background(0);
  }
  
  if (frame > FRAMERATE*1) {
    newMode();
  }
  
  sendData();
}

void drawLines() {
  background(0);
  stroke(255);
  
  long frame = frameCount - modeFrameStart;
  int x = int(frame % 5);
  
  for (int i = -x; i<WIDTH; i+=5) {
    line(i,0,i+8,8);
  }
  
  if (frame > FRAMERATE*5) {
    newMode();
  }
  
  sendData();
}

void drawLinesTheOtherWay() {
  background(0);
  stroke(255);
  
  long frame = frameCount - modeFrameStart;
  int x = int(frame % 5);
  
  for (int i = x-5; i<WIDTH; i+=5) {
    line(i+8,0,i,8);
  }
  
  if (frame > FRAMERATE*5) {
    newMode();
  }
  
  sendData();
}

void drawVertLine() {
  background(0);
  stroke(255);
  
  long frame = frameCount - modeFrameStart;

  if (int(random(10)) == 0)
    direction = -direction;
    
  position += direction;
  if (position < 0)
  {
    direction = 1;
    position = 0;
  }
  if (position >= WIDTH)
  {
    direction = -1;
    position = WIDTH-1;
  }
  
  line(position,0,position,HEIGHT-1);
  
  if (frame > FRAMERATE*20) {
    newMode();
  }
  
  sendData();
}

void drawFader() {
  int frame = int(frameCount - modeFrameStart);

  if (frame < 30) {
    background(int(frame % 30 / 30.0 * 255));
  }
  else if (frame >= 30 && frame < 60) {
    int f = 30-(frame-30);
    background(int(f % 30 / 30.0 * 255));
  }
  else if (frame >= 60 && frame < 120) {
    int f = frame-60;
    background(int(f % 30 / 30.0 * 255));
  }      
  else {
    newMode();
  }
  
  sendData();
}

void drawSticks() 
{  
  int frame = int(frameCount - modeFrameStart);
  int step = frame % WIDTH;
  
  if ((frame / WIDTH) % 2 == 0)
  {
    background(0);
    stroke(255);
  }
  else
  {
    background(255);
    stroke(0);
  }
  
  for (int y = 0; y < HEIGHT; y+=2) {
    line(0,          y,   step,  y);
    line(WIDTH-step, y+1, WIDTH, y+1); 
  }
  
  sendData();
  
  if (frame >= WIDTH*6)
    newMode();
}

void drawCurtain()
{
  background(0);
  stroke(255);
  
  int frame = int(frameCount - modeFrameStart);
  int step = frame % (WIDTH/2);

  line(step,         0, step,         HEIGHT-1);
  line(WIDTH-step-1, 0, WIDTH-step-1, HEIGHT-1);
  
  if (frame > WIDTH*4) {
    newMode();
  }
  
  sendData();  
}

void drawSpin() 
{  
  background(0);
  stroke(255);

  int frame = int(frameCount - modeFrameStart);
  int step = frame % (WIDTH+HEIGHT-2);
  
  if (step < WIDTH)
    line(step, 0, WIDTH-step-1, HEIGHT-1);
  else
    line(0, HEIGHT-(step-WIDTH+1)-1, WIDTH, step-WIDTH+1); 
  
  sendData();
  
  if (frame >= (WIDTH+HEIGHT-2)*10)
    newMode();
}

void sendDataGreetz() {
  int r;
  int i;
  int j;

  loadPixels();
  
  for (int y=0; y<HEIGHT; y++) {
    for (int x=0; x<WIDTH; x++) {
      j = y * WIDTH + x;
      if (VERTICAL)
        i = x * HEIGHT + y;
      else
        i = (x % 8) + floor(x / 8)*8*HEIGHT + y*8;
      
      r = (pixels[j] >> 16 & 0xFF);
      buffer[i+1] = (byte)((r>0) ? 255 : 0);
    }
  }
  
  udp.send(buffer,hostname,58082);
}

void sendData() {
  int r;
  int i;
  int j=0;
  
  loadPixels();
  
  for (int y=0; y<HEIGHT; y++) {
    for (int x=0; x<WIDTH; x++) {
      if (VERTICAL)
        i = x * HEIGHT + y;
      else
        i = (x % 8) + floor(x / 8)*8*HEIGHT + y*8;

      j = (y*ZOOM*(WIDTH*ZOOM))+(x*ZOOM);
      r = (pixels[j] >> 16 & 0xFF);
      
      //if (r>0)
      //  print(r+" ");
     
      buffer[i+1] = byte(r);
    }
  }

  udp.send(buffer,hostname,58082);
}

class Star {
  float x;
  float y;
  int z;
  float s;
  
  public Star(float s) {
    this.s = s;
    this.reset();
  }
  
  public void draw() {
    x = x + s;
    if (x>WIDTH*ZOOM)
      this.reset();
    
    noStroke();
    fill(z);
    rect(x,y,ZOOM,ZOOM);
  }
  
  public void reset() {
    x = -random(WIDTH*ZOOM);
    y = random(HEIGHT*ZOOM);
    //s = random(ZOOM)+1;
    z = int(s/ZOOM*255);
  }
}


class Burst {
  float x;
  float y;
  float d;
  float maxd;
  float speed;
  int intensity;
  
  public Burst()
  {
    init();
  }
  
  public void init()
  {
    x = random(WIDTH);
    y = random(HEIGHT);
    maxd = random(10);
    speed = random(5)/10 + 0.1;
    d = 0;
    intensity = 255;
  }
  
  public void draw(boolean fl)
  {
    if (fl)
      fill(0);
    else
      noFill();
    stroke(intensity);
    ellipse(x, y, d, d);
    d+= speed;
    if (d > maxd)
      intensity -= 15;
      
    if (intensity <= 0)
      init();
  }
}
