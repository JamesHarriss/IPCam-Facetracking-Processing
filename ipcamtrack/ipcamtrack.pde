import ipcapture.*;
import java.awt.*;
import gab.opencv.*;
import ddf.minim.*;



IPCapture cam;
OpenCV opencv;
//sound
//Minim minim;
AudioPlayer player;
AudioInput input;

void setup() {
  
  minim = new Minim(this);
  player = minim.loadFile("yeah.mp3");
  input = minim.getLineIn();
  
  size(640, 480);
  cam = new IPCapture(this, "http://192.168.11.53/videostream.cgi?user=admin&pwd=camera", "", "");
  cam.start();
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw() {
  if (cam.isAvailable()) {
    //scale(2);
    cam.read();
    opencv.loadImage(cam);
    image(cam, 0, 0);

    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    Rectangle[] faces = opencv.detect();
    println(faces.length);

    for (int i = 0; i < faces.length; i++) {
     
     if (i < faces.length){ 
    saveFrame();
    println("SNAP!");
    player.play();
    player.rewind();
    
     
   } else {
    
    player.close();
    
    
    
     }
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  
    }
   
  }
}

