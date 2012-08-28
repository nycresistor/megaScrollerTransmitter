class Warp extends Routine {
  float r;
  float rofs;
  float warpSpeed;
  Routine subroutine;
  boolean warpHorizontal;
  boolean warpVertical;
  float warpFactor;

  public Warp() {
    this.subroutine = null;
    warpHorizontal = false;
    warpVertical = true;
    warpSpeed = 2;
    warpFactor = 1;
  }

  public Warp(Routine subroutine, boolean warpHorizontal, boolean warpVertical, float warpSpeed, float warpFactor) {
    this.subroutine = subroutine;
    this.warpHorizontal = warpHorizontal;
    this.warpVertical = warpVertical;
    this.warpSpeed = warpSpeed;
    this.warpFactor = warpFactor;
  }

  void setup(PApplet parent) {
    super.setup(parent);

    if (this.subroutine != null) {
      this.subroutine.setup(parent);
    }
  }

  void hshift(int y, int xofs) {
    if (xofs < 0) 
      xofs = width + xofs;

    PImage tmp = get(width-xofs, y, xofs, 1);
    copy(0, y, width-xofs, 1, xofs, y, width-xofs, 1);    
    image(tmp, 0, y);
  }

  void vshift(int x, int yofs) {
    if (yofs < 0) 
      yofs = height + yofs;

    PImage tmp = get(x, height-yofs, 1, yofs);
    copy(x, 0, 1, height-yofs, x, yofs, 1, height-yofs);    
    image(tmp, x, 0);
  }

  void drawBackground() {
    if (subroutine != null) {
      subroutine.draw();

      if (subroutine.isDone) {
        newMode();
      }
    }
    else {
      background(0);
      noFill();
      ellipseMode(RADIUS);
      for (int i=0; i<10; i++) {
        stroke(i%2==0 ? color(255,64,64) : color(255,128,0));
        ellipse(width/2,height/2,i*(width/10),i*(height/10));  
      }
    }
  }

  void draw() {
    drawBackground();

    if (warpVertical) {
      for (int x=0; x<width; x++) {
        r = x*1.0/height*PI + rofs;
        vshift(x, int(sin(r)*(height*warpFactor)));
      }

      rofs += 0.0314 * warpSpeed;
    }

    if (warpHorizontal) {
      for (int y=0; y<height; y++) {
        r = y*1.0/width*PI + rofs;
        hshift(y, int(sin(r)*(width*warpFactor)));
      }

      rofs += 0.0314 * warpSpeed;
    }
  }
}

