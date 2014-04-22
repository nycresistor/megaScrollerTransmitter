import hypermedia.net.*;

/**
 * This class can be added to your sketches to make them compatible with an LED display.
 * Use Sketch..Add File and choose this file to copy it into your sketch.
 *
 * void setup() {
 *   // Constructor takes this, width, height.
 *   Dacwes dacwes = new Dacwes(this, 16, 16);
 *
 *   // Change this depending on how the sign is configured.
 *   dacwes.setAddressingMode(Dacwes.ADDRESSING_VERTICAL_FLIPFLOP);
 *
 *   // Include this to talk to the emulator.
 *   dacwes.setAddress("127.0.0.1");
 *
 *   // The class will scale things for you, but it may not be full brightness
 *   // unless you match the size.
 *   size(320,320);
 * }
 *
 * void draw() {
 *   doStuff();
 *
 *   // Call this in your draw loop to send data to the sign.
 *   dacwes.sendData();
 * }
 *
 **/

public class LEDDisplay {
  public static final int ADDRESSING_VERTICAL_NORMAL = 1;
  public static final int ADDRESSING_VERTICAL_HALF = 2;
  public static final int ADDRESSING_VERTICAL_FLIPFLOP = 3;
  public static final int ADDRESSING_HORIZONTAL_NORMAL = 4;
  public static final int ADDRESSING_HORIZONTAL_HALF = 5;
  public static final int ADDRESSING_HORIZONTAL_FLIPFLOP = 6;

  PApplet parent;
  UDP udp;
  String address;
  int port;
  int w;
  int h;
  int addressingMode;
  byte buffer[];
  int pixelsPerChannel;
  float gammaValue = 2.5;
  boolean enableGammaCorrection = false;
  boolean isRGB = false;
  int packetsPerFrame = 2;

  public LEDDisplay(PApplet parent, int w, int h, int packetsPerFrame, boolean isRGB, String address, int port) {
    this.parent = parent;
    this.udp = new UDP(parent);
    this.address = address;
    this.port = port;
    this.w = w;
    this.h = h;
    this.packetsPerFrame = packetsPerFrame;
    this.isRGB = isRGB;
//    int bufferSize = (isRGB ? 3 : 1)*(w*h)+1;
    int bufferSize = (isRGB ? 3 : 1)*(w*h)/packetsPerFrame;
    bufferSize = bufferSize+1; // first byte is part number
    buffer = new byte[bufferSize];
    this.addressingMode = ADDRESSING_VERTICAL_NORMAL;
    // TODO Detect this based on VERTICAL (h/2) vs. HORIZONTAL (w/2)
    this.pixelsPerChannel = 8;

    for (int i=0; i<bufferSize; i++) {
      buffer[i] = 0;
    }
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public void setPort(int port) {
    this.port = port;
  }

  public void setAddressingMode(int mode) {
    this.addressingMode = mode;
  }

  public void setPixelsPerChannel(int n) {
    this.pixelsPerChannel = n;
  }

  public void setGammaValue(float gammaValue) {
    this.gammaValue = gammaValue;
  }

  public void setEnableGammaCorrection(boolean enableGammaCorrection) {
    this.enableGammaCorrection = enableGammaCorrection;
  }

  private int getAddress(int x, int y) {
    if (addressingMode == ADDRESSING_VERTICAL_NORMAL) {
      return (x * h + y);
    }
    else if (addressingMode == ADDRESSING_VERTICAL_HALF) {
      return ((y % pixelsPerChannel) + floor(y / pixelsPerChannel)*pixelsPerChannel*w + x*pixelsPerChannel);
    }
    else if (addressingMode == ADDRESSING_VERTICAL_FLIPFLOP) {
      if (y>=pixelsPerChannel) {
        int endAddress = (x+1) * h - 1;
        int address = endAddress - (y % pixelsPerChannel);
        return address;
      }
      else {
        return (x * h + y);
      }
    }
    else if (addressingMode == ADDRESSING_HORIZONTAL_NORMAL) {
      return (y * w + x);
    }
    else if (addressingMode == ADDRESSING_HORIZONTAL_HALF) {
      return ((x % pixelsPerChannel) + floor(x / pixelsPerChannel)*pixelsPerChannel*h + y*pixelsPerChannel);
    }
    else if (addressingMode == ADDRESSING_HORIZONTAL_FLIPFLOP) {
      if (x>=pixelsPerChannel) {
        int endAddress = (y+1) * w - 1;
        int address = endAddress - (x % pixelsPerChannel);
        return address;
      }
      else {
        return (y * h + x);
      }
    }

    return 0;
  }

  public void sendMode(String modeName) {
    byte modeBuffer[] = new byte[modeName.length()+1];

    modeBuffer[0] = 2;
    for (int i = 0; i < modeName.length(); i++) {
      modeBuffer[i+1] = (byte)modeName.charAt(i);
    }

    udp.send(modeBuffer, address, port);
  }

  public void sendData() {
    PImage image = get();

    //    if (image.width != w || image.height != h) {
    //      image.resize(w,h);
    //    }

    image.loadPixels();
    loadPixels();

    int r;
    int g;
    int b;
    int pixelsPerPacket = (w*h)/packetsPerFrame;
    for (int p=0; p<packetsPerFrame; p++) {
      buffer[0] = byte(p);
      for (int offset = 0; offset<pixelsPerPacket; offset++) {
        int idx = offset + (p*pixelsPerPacket);

        r = int(red(image.pixels[idx]));
        g = int(green(image.pixels[idx]));
        b = int(blue(image.pixels[idx]));
          
          if (enableGammaCorrection) {
            r = (int)(Math.pow(r/256.0,this.gammaValue)*256*bright);
            g = (int)(Math.pow(g/256.0,this.gammaValue)*256*bright);
            b = (int)(Math.pow(b/256.0,this.gammaValue)*256*bright);
          }

//          buffer[(getAddress(x, y)*3)+3] = byte(r);
//          buffer[(getAddress(x, y)*3)+1] = byte(g);
//          buffer[(getAddress(x, y)*3)+2] = byte(b);
          buffer[(offset*3)+1] = byte(r);
          buffer[(offset*3)+2] = byte(b);
          buffer[(offset*3)+3] = byte(g);
      }
      udp.send(buffer, address, port);
    }
    updatePixels();
  }
}

