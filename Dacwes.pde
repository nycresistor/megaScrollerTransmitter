import hypermedia.net.*;

/**
 * This class can be added to your sketches to make them compatible with the sign.
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

public class Dacwes {
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

  public Dacwes(PApplet parent, int w, int h) {
    this.parent = parent;
    this.udp = new UDP(parent);
    this.address = "192.168.1.130";
    this.port = 58082;
    this.w = w;
    this.h = h;
    int bufferSize = 3*(w*h)+1;
    buffer = new byte[bufferSize];
    this.addressingMode = ADDRESSING_VERTICAL_NORMAL;
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
  
  private int getAddress(int x, int y) {
    if (addressingMode == ADDRESSING_VERTICAL_NORMAL) {
      return (y * w + x);
    }
    return 0;
  }    
  
  public void sendMode(String modeName) {
    byte modeBuffer[] = new byte[modeName.length()+1];
    
    modeBuffer[0] = 2;
    for(int i = 0; i < modeName.length(); i++) {
      modeBuffer[i+1] = (byte)modeName.charAt(i);
    }
    
    udp.send(modeBuffer,address,port);
  }
  
  public void sendData() {
    PImage image = get();
    
//    if (image.width != w || image.height != h) {
//      image.resize(w,h);
//    }
      
    image.loadPixels();

    int r;
    int g;
    int b;
    buffer[0] = 1;
    for (int y=0; y<h; y++) {
      for (int x=0; x<w; x++) {
        //r = int(brightness(image.pixels[y*w+x]));
        r = int(red(image.pixels[y*w+x]));
        g = int(green(image.pixels[y*w+x]));
        b = int(blue(image.pixels[y*w+x]));
        
        buffer[(getAddress(x,y)*3)+1] = byte(r);
        buffer[(getAddress(x,y)*3)+2] = byte(g);
        buffer[(getAddress(x,y)*3)+3] = byte(b);
      }
    }

    udp.send(buffer,address,port);
  }  
}
  

