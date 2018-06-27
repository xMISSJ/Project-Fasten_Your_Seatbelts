

class Upgrades {
  float cooldown;
  PImage tileImage = images[3];
  PImage upgradeImage = images[3];
  boolean destroyed = false;
  String name = "";

  void collision(Tiles t, Player p) {
  }

  void update(Player p) {
  }

  void action(Player p) {
  }
  void death(Player p) {
  }
}

class Food extends Upgrades {
  Food() {
    this.tileImage = upgradeTileImages[0]; 
    this.upgradeImage = upgradeImages[0] ;  
    this.name = "food";
  }
  void action(Player p) {
    pickup.image = particle[1];
    pickup.type = "imageNr";
    pickup.single = true;
    if (cooldown <= millis()) {
      cooldown = millis() + 1000;
      //sound[4].play();
    }
    score +=100 * meter.avgspeed;
    pickup.number =(int)( 100 * meter.avgspeed);
    p.food = (p.food + p.maxFood/2 > p.maxFood)?p.maxFood:p.food + p.maxFood/2;
    this.destroyed = true;
  }
}

class Wings extends Upgrades {

  Wings() {
    this.tileImage = upgradeTileImages[1]; 
    this.upgradeImage = upgradeImages[1];
    this.name = "wings";
  }
  int soundCooldown;
  int jumpCooldown;
  void action(Player p) {
    pickup.image = tileImage;
    pickup.single = true;
    pickup.type = "image";
    if (soundCooldown <= millis()) {
      soundCooldown = millis() + 1000;
      //sound[0].play();
    }
    p.upgrades.add(this);
    this.destroyed = true;
    cooldown = 5000 + millis();
  }
  void update(Player p) {

    if (cooldown <= millis() && p.jump == false) {
      p.upgrades.remove(this);
      p.jump = false;
      p.yimage = 0;
    }
    if (p.keyarr[3] == true && p.jump == false) {
      p.jump = true;
      jumpCooldown = millis() + 1000;
      //sound[3].play();
    }
    if (jumpCooldown <= millis() && p.jump == true) {
      p.upgrades.remove(this);
      p.jump = false;
      p.yimage = 0;
    }
    if (p.jump == true) {
      int jumpheight = 100;
      float increment = (float)jumpheight / 500;
      int timeleft =  (int)jumpCooldown - millis();
      if (timeleft <= 500) {
        p.yimage = (int)(timeleft * increment);
      }
      if (timeleft > 500) {
        p.yimage = (int)(jumpheight - ((timeleft * increment)-jumpheight));
      }
    }
  }
}

class Shield extends Upgrades {
  int botsnr = 1;
  Shield() {
    this.tileImage = upgradeTileImages[2]; 
    this.upgradeImage = upgradeImages[2];  
    this.name = "shield";
  }
  void action(Player p) {
    pickup.image = tileImage;
    pickup.type = "image";
    pickup.single = true;
    if (cooldown <= millis()) {
      cooldown = millis() + 1000;
      //sound[0].play();
    }
    p.upgrades.add(this);
    this.destroyed = true;
  }
  void collision(Tiles t, Player p) {

    if (t.type == "wall" && p.jump == false) {
      p.inv = millis() + 250;

      botsnr--;
    }
  }

  void update (Player p) {

    if (botsnr <= 0) {
      p.upgrades.remove(this);
    }
  }
}

boolean firstBoat = true;
class Boat extends Upgrades {
  boolean blink = false;
  int blinkCooldown = 0;
  boolean waterBlink = false;
  int WaterblinkCooldown = 0;
  int WaterblinkTime = 0;
  Boat() {
    this.tileImage = upgradeTileImages[3]; 
    this.upgradeImage = upgradeImages[3];    
    this.name = "boat";
  }
  void action(Player p) {
    pickup.image = tileImage;
    pickup.single = true;
    pickup.type = "image";
    if (cooldown <= millis()) {
      cooldown = millis() + 1000;
      //sound[0].play();
    }
    // p.food = p.maxFood;
    p.upgrades.add(this);
    this.destroyed = true;
    cooldown = 5000 + millis();

    if (firstBoat) {
      firstBoat = true;
      pickup.image = particle[2];
      pickup.type = "image";
      pickup.x =1025;
      pickup.y =675;
      pickup.lifespan =3000;
      pickup.spread = 0;
      pickup.speedY = 1;
      pickup.speedX = 0;
      
      pickup.single = true;
    }
  }
  void update(Player p) {



    if (cooldown - 500 <= millis()) {
      // millis() = het aantal milliseconden verlopen sinds het start van het spel
      // blinkCooldown = een tijd in de toekomst waar je een actie wilt uit voeren

      if (blink == false && blinkCooldown < millis()) {
        this.upgradeImage =   upgradeImages[5];//leeg plaatje
        blink = true;
        blinkCooldown = millis() + 50;
      } else if (blinkCooldown < millis()) {
        this.upgradeImage = upgradeImages[3];
        blink = false;
        blinkCooldown = millis() + 50;
      }
      // this.upgradeImage =
    } else if (cooldown - 1000 <= millis()) {
      // millis() = het aantal milliseconden verlopen sinds het start van het spel
      // blinkCooldown = een tijd in de toekomst waar je een actie wilt uit voeren

      if (blink == false && blinkCooldown < millis()) {
        this.upgradeImage =   upgradeImages[5];//leeg plaatje
        blink = true;
        blinkCooldown = millis() + 100;
      } else if (blinkCooldown < millis()) {
        this.upgradeImage = upgradeImages[3];
        blink = false;
        blinkCooldown = millis() + 100;
      }
      // this.upgradeImage =
    }

    if (cooldown <= millis()) {
      p.upgrades.remove(this);
    }
  }
}

class Speed extends Upgrades {
  Speed() {
    this.tileImage = upgradeTileImages[4]; 
    this.upgradeImage = upgradeImages[4];  
    this.name = "speed";
  }
  void action(Player p) {
    pickup.type = "image";
    cooldown = 1000 + millis();
    p.upgrades.add(this);

    // p.food = p.maxFood;
    // this.destroyed = true;
  }
  void update(Player p) {

    adjustSpeed = 1;
    //if (speed + adjustSpeed <= 0) {
    //  adjustSpeed = -(speed/2);
    //}
    if (millis() >= cooldown) {

      adjustSpeed = 0; 
      p.upgrades.remove(this);
    }
    //   println(adjustSpeed + " " + millis());
  }

  void death(Player p) {
    adjustSpeed = 0;
  }
}