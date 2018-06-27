class speedMeter {
  int x = width  - 266;
  int y = 60;
  PImage meter;
  PImage pointer;
  float lastSpeed = 1;
  float displayRot = -1.5;
  float avgspeed = 0;
  
  //this constructor loads the images from the data folder
  speedMeter() {
    this.meter = loadImage("Images/UI/speed_chart.png");
    this.pointer = loadImage("Images/UI/pointer.png");
  }
    //this function takes the current and maximum speed and rotates the speedometer accordingly
  void update(int speed, int maxspeed) {
    float increment = (float)3 / maxspeed;
     image(meter, x,y);
    
    translate(x + 128,y+134 );
    float rot = ((increment* (((float)speed+lastSpeed)/2)))-1.5;
    avgspeed = (((float)speed+lastSpeed)/2);
    lastSpeed = speed;
    if(displayRot < rot - 0.01){
     displayRot += 0.01; 
    }else if( displayRot > rot + 0.01){
     displayRot -=0.01; 
    }
    
    //setting rotation, imagemode and translate to draw the speedometer
    rotate(displayRot);
    imageMode(CENTER);
     image(pointer,0,0);
         
      rotate(-displayRot);
      translate(-(x + 128),-(y+134) );
      imageMode(1);
     
  }
}