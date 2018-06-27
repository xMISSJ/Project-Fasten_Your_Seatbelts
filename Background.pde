class Biomes {
  int biomeSwap = 1000;
  int biome = 1;
  int nextBiome = biome;
  int biomeCounter = 0;
  public color [][] biomeColors  = new color [4][2];
  IntList objectXCollection = new IntList ();
  IntList objectAttributeCollection = new IntList();
  int scrollSpeed = 3;
  int objectTimer;
  int objectSpacing = 30;
  int skyR, skyG, skyB, groundR, groundG, groundB;
  color sky;
  color ground;
  boolean swapping;
  boolean colorInit = false;

  void biomeInitialise() {
    objectSpacing = 30;
    biome = 1;
    //normal grassy biome
    biomeColors [0][0] = color(60, 180, 250);
    biomeColors [0][1] = color(30, 140, 100);
    //autumny biome
    biomeColors [1][0] = color(224, 201, 157);
    biomeColors [1][1] = color(224, 124, 53);
    //gray biome
    biomeColors [2][0] = color(224, 224, 224);
    biomeColors [2][1] = color(177, 204, 114);
    //winter Biome
    biomeColors [3][0] = color(232, 250, 255);
    biomeColors [3][1] = color(86, 174, 167);
    sky = biomeColors[0][0];
    ground = biomeColors[0][1];
  }

  void biomeDraw () {
    
    //drawing the sky
    background(sky);
    
    //running through the arraylist and drawing the correct stuff for the biome the player is currently in. always happens, 
    for (int i = objectXCollection.size()-1; i >=0; i--) {
      switch(biome) {
      case 1: 
        drawBiome1(objectXCollection.get(i), objectAttributeCollection.get(i));
        break;
      case 2: 
        drawBiome2(objectXCollection.get(i), objectAttributeCollection.get(i));
        break;
      case 3:
        drawBiome3(objectXCollection.get(i), objectAttributeCollection.get(i));
        break;
      case 4:
        drawBiome4(objectXCollection.get(i), objectAttributeCollection.get(i));
        break;
      }
    }

    fill(ground);
    //drawing the ground
    quad(0, 100, width, height, width, height, 0, height);

    //moving and removing entries from the arraylists. moving happens every frame and removing happens when an entry scrolls out of the screen
    //this only happens when the game is playing
    if (playstate) {
      for (int i = objectXCollection.size()-1; i >=0; i--) {
        objectXCollection.add(i, (int)scrollSpeed);
        if (objectXCollection.get(i) >= width+100) {
          objectXCollection.remove(i);
          objectAttributeCollection.remove(i);
        }
      }
      
      //adding and entries to the arraylists at random intervals and restarting the timer to add one. only happens when not swapping biomes
      //also running the biomeswitcher
      if (swapping == false) {
        biomeswitch();
        objectTimer += 1;
        if ( objectTimer == objectSpacing) {
          objectSpacing = 50 + ((int) random(0, 250));
          objectTimer = 0;
          objectAttributeCollection.append((int) random(1, 11));
          objectXCollection.append(-300);
        }
      } 
      //if biomes are swapping, generates a new biome, executes colorchange command
      else {
        colorChange(biome, nextBiome);
        if (objectXCollection.size() == 0) {
          biome = nextBiome;
          sky = biomeColors[biome-1][0];
          ground = biomeColors[biome-1][1];
          swapping = false;
          colorInit = false;
        }
      }
    }
  }
  
   //counts until reaching the designated biomeswap point. designates a random biome and sets swapping to true.
  int biomeswitch() {
    biomeCounter += 1;
    if (biomeCounter == biomeSwap) {
      swapping = true;
      nextBiome = (int)random(1,5);
      biomeCounter = 0;
    }
    return biome;
  }  
  //draws some cool buildings
  void drawBiome1(int buildingX, int buildingSize) {

    fill(100);
    quad(buildingX, (buildingX * 0.5), buildingX + 60, 
      (buildingX * 0.5)-60/2, buildingX + 60 + (50 +(buildingSize * 10)), 
      (buildingX * 0.5)-60/2 + (0.5 * (50 +(buildingSize * 10))), 
      buildingX + 60 + (+ 50 +(buildingSize * 10)), 1000);

    fill(200);
    quad(buildingX, height, buildingX, 
      (buildingX * 0.5), (buildingX) + 50 +(buildingSize * 10), 
      (buildingX * 0.5) + ((50 + buildingSize * 10)*0.5), 
      (buildingX) + 50 + (buildingSize * 10), height);
  }
    void drawBiome2(int hillposition, int hillSize) {
      fill(224, 124, 53);
 
      ellipse(hillposition, hillposition/2 + 90, 120 + 10*hillSize, 120 + 10* hillSize);
      
  }
  
  //draws some trees
  void drawBiome3(int treePosition, int treeSize) {
    fill(153,111,74);
    quad(treePosition, treePosition / 2 + 70,
    treePosition + 40, (treePosition + 40) /2 + 70,
    treePosition + 40, (treePosition + 40) /2 - 20,
    treePosition, treePosition /2 - 20);
    
    fill(87,175,96);
    quad(treePosition - 40, (treePosition - 40) /2 + 30 ,
    treePosition + 80, (treePosition + 80) /2 + 30,
    treePosition + 20, (treePosition - 100 - (30*treeSize))/2,
    treePosition + 20, (treePosition - 100 - (30*treeSize))/2);
  }
  
  //draws some icebergs
  void drawBiome4(int iceBergPos, int iceBergSize) {
    
    fill(124,226,255);
    quad(iceBergPos - 40 - (iceBergSize * 5), (iceBergPos - 40 - (iceBergSize * 5)) /2 + 60,
    iceBergPos + 80 + (iceBergSize * 5), (iceBergPos + 80 + (iceBergSize * 5)) /2 + 60,
    iceBergPos + 20, (iceBergPos - 100 - (20*iceBergSize))/2,
    iceBergPos + 20, (iceBergPos - 100 - (20*iceBergSize))/2);
    
    
  }
  //method to fade from the colors of one biome to the next. reads every RGB value of both the sky and ground and compares it to the next biome's 
  //colors. sets colorinit to true when it has finished reading in all needed information and then fades to the next biome. stops upon reaching
  //each desired color.
  void colorChange (int curBiome, int comingBiome) {
    if (colorInit == false) {
      skyR = (int)red(biomeColors[curBiome-1][0]);
      skyG = (int)green(biomeColors[curBiome-1][0]);
      skyB = (int)blue(biomeColors[curBiome-1][0]);
      groundR = (int)red(biomeColors[curBiome-1][1]);
      groundG = (int)green(biomeColors[curBiome-1][1]);
      groundB = (int)blue(biomeColors[curBiome-1][1]);
    }
    colorInit = true;
    sky = color(skyR, skyG, skyB);
    ground = color(groundR, groundG, groundB);
    if (skyR > (int)red(biomeColors[comingBiome-1][0])) skyR -=1;
    else if (skyR < (int)red(biomeColors[comingBiome-1][0]))skyR +=1; 

    if (skyG > (int)green(biomeColors[comingBiome-1][0])) skyG -=1;
    else if (skyG < (int)green(biomeColors[comingBiome-1][0])) skyG +=1;

    if (skyB > (int)blue(biomeColors[comingBiome-1][0])) skyB -=1;
    else if (skyB < (int)blue(biomeColors[comingBiome-1][0])) skyB +=1;

    if (groundR > (int)red(biomeColors[comingBiome-1][1])) groundR -=1;
    else if (groundR < (int)red(biomeColors[comingBiome-1][1])) groundR +=1;

    if (groundG > (int)green(biomeColors[comingBiome-1][1])) groundG -=1;
    else if (groundG < (int)green(biomeColors[comingBiome-1][1])) groundG +=1;

    if (groundB > (int)blue(biomeColors[comingBiome-1][1])) groundB -=1;
    else if (groundB < (int)blue(biomeColors[comingBiome-1][1])) groundB +=1;
  }
}  