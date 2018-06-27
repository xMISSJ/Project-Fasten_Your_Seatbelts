class Player {
  boolean[] keyarr = new boolean[4];
  boolean jump = false;
  int maxFood = 1000;
  int food = 1000;
  int y = 2;
  int yimage = 0;
  int x = 0;
  int inv = -1;
  PImage img = playerImg;
  boolean blink =false;
  int blinkCooldown = 0;
  int upgradeSize = 0;
  ArrayList<Upgrades> upgrades = new ArrayList<Upgrades>();
  ArrayList<String> names = new ArrayList<String>();
  boolean playerHasUpgrades(String Upgrades) {  

    for (int i = 0; i < upgrades.size(); i++) { 
      if (upgrades.get(i).name == Upgrades) {
        return true;
      }
    }
    return false;
  }
  boolean removeLastUpgrade() {
    inv = millis() + 250;
    if (upgrades.size() <= 0) {
      return false;
    }
    upgrades.remove(upgrades.size() -1);
    return true;
  }

  //------------------------------------------------------------------------------------------------
  void update(float xpos, float ypos) {

    if (inv >  millis()) {

      if (blink == false && blinkCooldown < millis()) {
        this.img =   upgradeImages[5];//leeg plaatje
        blink = true;
        blinkCooldown = millis() + 50;
      } else if (blinkCooldown < millis()) {
        this.img = playerImg;
        blink = false;
        blinkCooldown = millis() + 50;
      }
    } else {
      this.img = playerImg;
    }

    if (upgradeSize != upgrades.size()) {
      upgradeSize = upgrades.size();
      names = new ArrayList<String>();
      for (int i = upgrades.size()-1; i >=0; i--) {
        if (names.contains(upgrades.get(i).name)) {
          upgrades.remove(upgrades.get(i));
        }
        names.add(upgrades.get(i).name);
      }
    }
    if (upgrades.size() >0) {
      for (int i = upgrades.size()-1; i >=0; i--) {
        //println(i);
        Upgrades current = upgrades.get(i);
        current.update(this);
        image(current.upgradeImage, xpos, ypos-yimage);
      }
    }
  }



  boolean action(int Px, int Py) {
    x = Px;
    //println(tileOn[y+1].type);
    //println(tileOn[y-1].type);
    if (keyarr[0] == true) {
      keyarr[0] = false;
      if ( Py+1 < test[0].length && test[Px-1][Py +1].collisionSide(this))y++;
    }
    if (keyarr[1] == true) {
      keyarr[1] = false;
      if (Py -1 >=0 && test[Px+1][Py -1].collisionSide(this))y--;
    }

    if (test[Px-1][Py].upgrade != null && jump == false && !test[Px-1][Py].upgrade.destroyed) {

      test[Px-1][Py].upgrade.action(this);
    }

    if (!test[Px-1][Py].collision(this)) {

      if (this.upgrades.size() >0) {
        for (int i = player.upgrades.size()-1; i >=0; i--) {
          //println(i);
          Upgrades current = upgrades.get(i);
          current.collision(test[Px-1][Py], this);
        }
      }
      return true;
    }
    return false ;
    //return true;
  }

  //------------------------------------------------------------------------------------------------  
  void food() {
    food-=speed;
    if (food <=0) {
      death = true;
    }
    fill(255, 200, 200);

    rect(20 + ((width-40)-(float)(((double)(width-40)/(double)maxFood)*(double)maxFood)), height - 40, (float)(((double)(width-40)/(double)maxFood)*(double)maxFood), 20);
    fill(255, 0, 0);
    if (food != 0 && maxFood / food >2 && food%8 > 4) {

      fill(255, 200, 200);
    }
    rect(20 + ((width-40)-(float)(((double)(width-40)/(double)maxFood)*(double)food)), height - 40, (float)(((double)(width-40)/(double)maxFood)*(double)food), 20);
    image(upgradeTileImages[0], 0 + ((width-40)-(float)(((double)(width-40)/(double)maxFood)*(double)food)), height-70);


    // image(upgradeTileImages[0],width-40,height-70);
  }
}