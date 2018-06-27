class Particle {
  PImage particle;


  int lifespan;
  float speedY;
  float speedX;
  float x;
  float y;
  int size = 1;
  boolean alive = true;
  String type = "ellipse";
  color colour = color(255, 255, 255);
  int transparancy = 255;
  int lifeEnd = 0;
  String text = "text";
  int number = 0;
  int numberWidth = 0;
  int numberHeight = 0;
  /// boolean fade = false;


  Particle(float x, float y, float speedX, float speedY, int lifespan, String type) {
    this.type = type;
    lifeEnd = lifespan;
    this.lifespan = lifespan +millis();
    this.x = x;
    this.y = y;
    this.speedX = speedX;
    this.speedY = speedY;
  }
  void addImage(PImage img) {
    this.particle = img;
    numberWidth = img.width/3;
    numberHeight = img.height/4;
  //  this.particle.resize(0, this.particle.width*size);
  }
  void update() {
    int mil = millis();
    if (lifespan < mil) {
      alive = false;
      return;
    }

    switch(type) {
    case "ellipse":
      noStroke();
      fill(colour, transparancy);
      ellipse(x, y, 10*size, 10*size);
      break;
    case "text":
      noStroke();
      fill(colour, transparancy);
      textSize(size);
      text(text, x, y);
      break;
    case "image":
      tint(colour, transparancy);
      image(particle, x, y);
      tint(255, 255);
      break;
    case "imageNr":

      //copy(sourceImage, 
      //  frame*frameWidth, 0, frameWidth, frameHeight, 
      //  x-frameWidth/2, y-frameHeight/2, frameWidth, frameHeight);

      int[] numbers = {0,0,0,0,0,0,0};
      int nrpos = numbers.length-1;
      int number2 = number;
      number2 *=10;
      boolean check = false;
      while (number != 0 && nrpos >= 0) {
        number2/=10;
        if (number2%10 !=0) {
         
          numbers[nrpos] = number2%10;
          number2-= number2%10;
        }
        nrpos--;
      }
      tint(colour, transparancy);
      for (int i = 0; i < numbers.length; i++) {
      if (numbers[i] == 0 && !check) {
      continue;
      }else{
       check = true; 
      }
        if (numbers[i] == 0) {
          
          copy(particle, numberWidth, numberHeight*3, numberWidth,numberHeight, (int)x+(32*i)- 160, (int)y, 32, 32);
        } else {
          
           copy(particle, numberWidth*( (numbers[i]+2)%3), numberHeight* (int)((numbers[i]-1)/3), numberWidth,numberHeight, (int)x+(32*i) - 160, (int)y, 32, 32);
          //copy(particle, numberWidth, numberHeight*3, particle.width, particle.height, (int)x, (int)y, 128, 128);
         // copy(particle, numberWidth*( 3-(numbers[i]%3)), numberHeight*( 0), numberWidth, numberHeight, (int)x, (int)y, numberWidth, numberHeight);
        }
      }

      tint(255, 255);
      break;
    }
    x += speedX;
    y += speedY;
    fade();
  }

  void fade() {
    int lifeLeft = lifespan - millis();
    if (lifeLeft <= (lifeEnd/3)*2) {
      float time = (lifeEnd/2);
      float transparencyParts = 255 / time;
      transparancy = (int)transparencyParts * lifeLeft;
    }
  }
}


class ParticleGen {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int interval = 10;
  int cooldown = 0;
  float spread = 0.5;
  float spray = 0;
  int lifespan = 500;
  int amount = 5;
  float speedX = 0;
  float speedY = -5;
  int x = 500;
  int y = 500;
  int mil = 0;
  String type = "ellipse";
  color colour = color(255, 255, 255, 255);
  boolean activeParticle = true;
  PImage image;
  boolean single = false;
  int number = 123;
  void draw() {

    if (activeParticle == false) {
      return;
    }

    //update all particles
    for (int i = particles.size() -1; i >=0; i--) {
      Particle p = particles.get(i);
      p.update();
      if (!p.alive) {
        particles.remove(p);
      }
    }


    mil = millis();
    if (cooldown < mil && interval != -1 || single == true) {


      single = false;
      for (int i =  amount; i>=0; i--) {
        float randsprayx = (spray != 0)?random(spray)-(spray/2):0;
        float randsprayy = (spray != 0)?random(spray)-(spray/2):0;
        float randspreadx = (spread != 0)?random(spread)-(spread/2):0;
        float randspreadY = (spread != 0)?random(spread)-(spread/2):0;
        Particle p = new Particle(x+randsprayx, y+randsprayy, speedX+randspreadx, speedY+randspreadY, lifespan, type);
        if (type == "image" ||type == "imageNr") {
          p.addImage( image);
        }
        if (type == "imageNr") {
          p.number = number;
        }
        p.colour = colour;
        particles.add(p);
      }
      cooldown = mil + interval;
    } else {
      //cooldown = mil + interval;
    }
  }
}