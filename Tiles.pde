/* dit is het parent object van alle tiles
 hier staat alles in wat in ieder tile moet zitten (bv: afbeelding)
 */
ArrayList<Tiles> allTiles = new ArrayList<Tiles>();
class Tiles {
  boolean placeable = true;  
  PImage tileImg;
  String type;
  //dit is een upgrade, hier is hij leeg. hier kan ik als ik wil een upgrade aan een tile toevoegen.
  Upgrades upgrade;
  // deze functie ga ik uit voeren als een player collide met een tile
  void update() {
  }
  public boolean collision(Player p) {
    return true;
  }
  public boolean collisionSide(Player p) {
    return true;
  }
}

// deze class en alle classen hieronder zijn een child van de Tiles class. dit will zeggen dat ze alle atributen van de tile class hebben en ook nog eigen aanpassingen/toevoegingen kunnen hebben.
class Wall extends Tiles {
  int intence = 1;
  Wall(PImage[] tileImg) {
    this.tileImg = tileImg[7];
    this.type = "wall";
    this.placeable = false;
    //intence = speed;
  }
  int shake = 0;
  int shakestart = 16;
  public boolean collision(Player p) {

    if (!(p.inv > millis()) && p.jump == false) {
      collision.single = true;
      //sound[2].play();
      if (!p.playerHasUpgrades("shield") ) {
        
        death = true;
      }else{
       this.tileImg = images[3]; 
      }
    }
    if (!(p.inv > millis()) ) {
      return false;
    }
    return true;
  }
  public boolean collisionSide(Player p) {
    return false;
    //if (!p.removeLastUpgrade()) {
    //  start();
    //}
  }
  public void update() {
    if (shake > 0) {
      if (shake %4 == 0) {
        shiftx -=5 * intence; 
        shifty -=5* intence;
      } else if (shake % 2 ==0) {
        shiftx +=5* intence;
        shifty +=5* intence;
      }
      shake--;
    }
  }
}



class Path extends Tiles {
  Path(PImage[] tileImg) {
    this.tileImg = tileImg[0];
    this.type = "path";
  }
  public boolean collision(Player p) {

    smoke.spray = 5;
    smoke.spread = 1;
    smoke.amount = 1;
    smoke.colour = color(200, 150, 150);
    return true;
  }
}



class Hole extends Tiles {
  Hole(PImage[] tileImg) {
    this.tileImg = tileImg[8];
    this.type = "hole";
    this.placeable = false;
  }
}
class Water extends Tiles {
  Water(PImage[] tileImg) {
    this.tileImg = tileImg[4];
    this.placeable = false;
    this.type = "path";
  }

  public boolean collision(Player p) {
    if (p.upgrades.size() >0) {
      for (int i = p.upgrades.size()-1; i >=0; i--) {
        if (p.upgrades.get(i).name == "boat") {

          smoke.spray = 15;
          smoke.spread = 1;
          smoke.colour = color(75, 125, 255);

          return true;
        }
      }
    }

    //shake += shakestart;
    // shakestart=0;
    death = true;

    return false;
  }
  public boolean collisionSide(Player p) {
    if (p.upgrades.size() >0) {
      for (int i = p.upgrades.size()-1; i >=0; i--) {
        if (p.upgrades.get(i).name == "boat") {
          return true;
        }
      }
    }

    return false;
  }
}