//import processing.sound.*;
SpriteSheet spriteSheet;
//v8 compleet

// create variables
double tileSize = 64;
PImage img;
PImage arrowUp;
PImage arrowLeft;
PImage arrowRight;
PImage xKey;
PImage zKey;
PImage wings;
int orgspeed = 1;
int speed = orgspeed;
int adjustSpeed = 0;
int maxspeed = 5;
int score = 0;
boolean muziek = true;
// verplaats begin path
int shiftx = -256;
int shifty = -258; /*keep this at half of shiftx*/
// history of scores
FloatList scores = new FloatList();
// save path x,y
int spendMillis = millis();
float missedFrames;
Tiles [][] test = new Tiles[60][6];
PImage [] images = new PImage[10];
PImage [] UIimages = new PImage[2];
PImage [] upgradeImages = new PImage[10];
PImage [] upgradeTileImages = new PImage[10];
PImage [] particle = new PImage[10];
PImage playerImg; 
boolean death;
Player player = new Player();
Biomes theBiomes = new Biomes();
speedMeter meter;
//SoundFile [] sound = new SoundFile[10];

ParticleGen smoke = new ParticleGen();
ParticleGen pickup = new ParticleGen();
ParticleGen collision = new ParticleGen();
ParticleGen foodParticle = new ParticleGen();

scoreboard resultaat = new scoreboard();
void setup() {


  meter  = new speedMeter();
  frameRate(60);
  size(1600, 900);
  theBiomes.biomeInitialise();
  // Images must be in the "data" directory to load correctly

  //def img
  img = loadImage("Images/Tiles/basic_tile.png");
  // player img

  spriteSheet = new SpriteSheet("Images/Player/Player_animated.png", 4);

  // tiles img
  images[0] = loadImage("Images/Tiles/basic_tile.png");
  images[1] = loadImage("Images/Tiles/water_tile.png");
  images[2] = loadImage("Images/Tiles/palm_tile.png");
  images[3] = loadImage("Images/Tiles/flat_tile_cracked.png");
  images[4] = loadImage("Images/Tiles/water_tile.png");
  images[5] = loadImage("Images/Tiles/basic_tile.png");
  images[6] = loadImage("Images/Tiles/basic_tile.png");
  images[7] = loadImage("Images/Tiles/flat_tile.png");
  images[8] = loadImage("Images/Tiles/water_tile.png");

  //backgrounds
  UIimages[0] = loadImage("Images/UI/scoreboard.png");
  UIimages[1] = loadImage("Images/UI/dinodashlogo.png");

  // Imports icons for the controls
  arrowUp = loadImage("Images/Icons/ArrowUp.png");
  arrowLeft = loadImage("Images/Icons/ArrowLeft.png");
  arrowRight = loadImage("Images/Icons/ArrowRight.png");
  xKey = loadImage("Images/Icons/xkey.png");
  zKey = loadImage("Images/Icons/zkey.png");
  wings = loadImage("Images/Icons/wings.png");


  //upgrade img
  upgradeImages[0] = loadImage("Images/Objects/food.png");
  upgradeImages[1] = loadImage("Images/Objects/wings1.png");
  upgradeImages[2] = loadImage("Images/Objects/shield2.png");
  upgradeImages[3] = loadImage("Images/Objects/boat1.png");
  upgradeImages[4] = loadImage("Images/Objects/empty.png");
  upgradeImages[5] = loadImage("Images/Objects/empty.png");

  //upgrade on tile img
  upgradeTileImages[0] = loadImage("Images/Objects/food.png");
  upgradeTileImages[1] = loadImage("Images/Objects/wings.png");
  upgradeTileImages[2] = loadImage("Images/Objects/shield.png");
  upgradeTileImages[3] = loadImage("Images/Objects/boat.png");
  upgradeTileImages[4] = loadImage("Images/Objects/speed.png");

  //sounds
  //sound[0] = new SoundFile(this, "Sounds/pickup_sound.wav");
  //sound[1] = new SoundFile(this, "Sounds/main_sound.wav");
  //sound[2] = new SoundFile(this, "Sounds/collision_sound.wav");
  //sound[3] = new SoundFile(this, "Sounds/jump_sound.mp3");
  //sound[4] = new SoundFile(this, "Sounds/eat_sound.wav"); //made by: Koops
  /*
  source sounds:
   main sound:  
   https://www.youtube.com/watch?v=vX1xq4Ud2z8&list=PLobY7vO0pgVKn4FRDgwXk5FUSiGS8_jA8
   
   pickup sound, eat sound, jump sound:
   www.freesounds.org
   */

  //sound volume
  //sound[0].amp(0.5);
  //sound[1].amp(0.1);
  //sound[2].amp(0.2);
  //sound[3].amp(0.5);
  //sound[4].amp(0.5);


  //particles 
  particle[0] = loadImage("images/particles/wipwolk.png");
  particle[1] = loadImage("images/particles/pngnumbers.png");
  particle[2] = loadImage("images/particles/Arrow.png");

  pickup.interval = -1;
  pickup.amount = 0;
  pickup.image = images[3];
  pickup.type = "image";
  pickup.lifespan = 250;
  collision.interval = -1;
  collision.amount = 15;
  collision.spread =8;
  collision.lifespan = 250;
  collision.colour = color(150, 150, 150, 150);
  collision.speedX = 0;
  collision.speedY = 0;



  //sound[1].loop();

  start(true);
}

boolean[][] ghost =  new boolean[2][test[0].length];
void  start() {
  start(false);
}
void start(boolean first) {
  player.y = 2;
  player.food = player.maxFood;
player.jump = false;
player.yimage = 0;
  for (int i = player.upgrades.size()-1; i >= 0; i--) {

    player.upgrades.get(i).death(player);
  }

  player.upgrades = new ArrayList<Upgrades>();
  for (int i = 0; i < ghost[0].length; i++) {
    ghost[0][i] = true;
    ghost[1][i] = true;
  }

  speed = orgspeed;
  score =0;
  //for (int i = 0; i < images.length-2; i++) {
  //  images[i] = images[0];
  //}
  int startfrom = 0;
  if (!first) {
    startfrom = 35;
  }
  for (int i = test.length - 1; i >=startfrom; i--) {
    for (int i2 = 0; i2 < test[i].length; i2++) {
      //println(i2);
      Tiles fill = new Path(images);
      test[i][i2] = fill;
      if (i2 == 0 || i2 == test[i].length -1) {
        fill = new Water(images);
        test[i][i2] = fill;
      } else if (i == 30-i2) {
        fill.upgrade = new Food();
        test[i][i2] = fill;
      }
    }
  }
}

int x = 0;
int y = 0;
int xmove = 0;
int ymove = 0;

//------------------------------------------------------------------------------------------------
void draw() {

  noStroke();
  if (speed != 0) {
    score += 1 * speed;
    speed = (speed > maxspeed) ? maxspeed:orgspeed + (int)((score/1000 - (score/1000 %1))/(speed));
    speed = (speed > maxspeed) ? maxspeed:speed;
    if (adjustSpeed != 0) {

      speed = adjustSpeed;
    }
  }
  theBiomes.biomeDraw();

  smoke.speedY = meter.avgspeed;
  smoke.speedX = meter.avgspeed*2;
  pickup.speedY = meter.avgspeed-6;
  pickup.speedX = meter.avgspeed*2;




  // Shows text for the controls
  String controls = "CONTROLS";
  fill(255, 255);
  textSize(16);
  textAlign(LEFT);
  text(controls, 30, height - 185, 100, 80);

  String pause = "Pause";
  fill(255, 255);
  textSize(16);
  textAlign(LEFT);
  text(pause, 30, height - 160, 100, 80);

  String mute = "Mute";
  fill (255, 255);
  textSize(16);
  textAlign(LEFT);
  text(mute, 30, height - 133, 100, 80);

  String movement = "Movement";
  fill(255, 255);
  textSize(16);
  textAlign(LEFT);
  text(movement, 30, height - 107, 100, 80);

  String jump = "Jump       +";
  fill(255, 255);
  textSize(16);
  textAlign(LEFT);
  text(jump, 30, height - 82, 100, 80);

  // Imports icons for the controls
  arrowUp = loadImage("Images/Icons/ArrowUp.png");
  arrowLeft = loadImage("Images/Icons/ArrowLeft.png");
  arrowRight = loadImage("Images/Icons/ArrowRight.png");
  xKey = loadImage("Images/Icons/xkey.png");
  zKey = loadImage("Images/Icons/zkey.png");
  wings = loadImage("Images/Icons/wings.png");

  // Positions the icons
  image(arrowUp, 72, height - 87);
  image(arrowLeft, 115, height - 112);
  image(arrowRight, 142, height - 112);
  image(xKey, 78, height - 164);
  image(zKey, 70, height - 137);
  image(wings, 113, height - 109);


  drawCity();
  int x =31 - (player.y - 15);
  menu();
  deathscreen();


  if (playstate) {
    player.action(x, player.y);
    player.food();
    fill(0, 150, 0);  
    textSize(44);
    textAlign(RIGHT);
    text(score, width-25, 50); 
    textAlign(LEFT);
    meter.update(speed, maxspeed);
  } else if (death ==  true || pausestate == true) {    
    resultaat.draw();
  }

  // fill (0);
  // rect(0, 0, 100, 100);
  // fill (255);
  //text(frameRate, 0, 32);
  smoke.draw();
  collision.draw();

  pickup.draw();
  spriteSheet.update();
}



//------------------------------------------------------------------------------------------------
void drawCity() {



  while (y< test[0].length) {

    while (x< test.length) {

      img = test[x][y].tileImg;
      //println(img.height-tileSize);

      image(img, x * (float)(tileSize/2) + xmove + shiftx, ( y * (float)(tileSize/2) + x * (float)(tileSize/4) + ymove +175 + shifty)-(float)(img.height-tileSize));

      test[x][y].update();
      if (test[x][y].upgrade != null && test[x][y].upgrade.destroyed == false) {
        image(test[x][y].upgrade.tileImage, x * (float)(tileSize/2)  + xmove + shiftx, y * (float)(tileSize/2) + x * (float)(tileSize/4) + ymove +175 + shifty);
        //test[x][y].upgrade.update(player);
      }
      if (y > -1 && y < test[0].length && x > 30 - (y-15) && x < 32 - (y-15) && player.y == y) {
        //positie player

        spriteSheet.x = x * (int)(tileSize/2) + 32 + shiftx;
        spriteSheet.y = y * (int)(tileSize/2) + x * (int)(tileSize/4) + 205 + shifty- player.yimage;

        spriteSheet.draw();
        player.update(x * (float)(tileSize/2) + shiftx, y * (float)(tileSize/2) + x * (float)(tileSize/4) +175 + shifty);

        smoke.x =  (int)(x * (float)(tileSize/2) + shiftx+38);
        smoke.y = (int)( y * (float)(tileSize/2) + x * (float)(tileSize/4) +48+175 + shifty)-player.yimage;
        x--;
        pickup.x =(int)(x * (float)(tileSize/2)  + xmove + shiftx);
        pickup.y =  (int)(y * (float)(tileSize/2) + x * (float)(tileSize/4) + ymove +175 + shifty);
        x++;
        collision.x =pickup.x +15 ;
        collision.y =pickup.y + 15;
      }

      x ++;
    }



    x=0;
    y++;
  }
  y=0;
  if (speed >0) {
    if (spendMillis < millis() - (1000/60)) {
      missedFrames += ((spendMillis - (millis() - (1000/60))) * -1)/(1000/60);
    }

    speed += (int) missedFrames;
    missedFrames -= (int) missedFrames;
  }
  spendMillis = millis();

  xmove+= 2 * speed;
  ymove+= 1 * speed;

  if (xmove >= (tileSize/2)) {
    xmove = xmove - (int)(tileSize/2);
    ymove = xmove/2;

    for (int i = test.length-1; i > 0; i--) {
      for (int i2 = 0; i2 < test[i-1].length; i2++) {
        test[i][i2] = test[i-1][i2];
      }
    }
    DrawPath();
  }
}

//------------------------------------------------------------------------------------------------
void keyPressed() {
  
  //mute main muziek
  if (key == 'z' && muziek == false) {
    //sound[1].loop(); 
    muziek = true;
  } else if (key == 'z' && muziek == true) { 
    //sound[1].stop(); 
    muziek = false;
  }
  
  if (key == 'x') player.keyarr[2] = true;
  
  if (key == CODED) {
    if (keyCode == LEFT) player.keyarr[0] = true;
    if (keyCode == RIGHT) player.keyarr[1] = true;
    if (keyCode == UP) player.keyarr[3] = true;
  }
}

//------------------------------------------------------------------------------------------------
void keyReleased() {
  if (key == 'x') player.keyarr[2] = false;
  if (key == CODED) {
    if (keyCode == LEFT) player.keyarr[0] = false;
    if (keyCode == RIGHT) player.keyarr[1] = false;
    if (keyCode == UP) player.keyarr[3] = false;
  }
}