int random =0;
String type = "path";
String upgrade = "";
IntList pathOptions;
int foodCountDown = 0;
void DrawPath() {
  foodCountDown--;
  //create random tiles
  for (int i = 0; i < test[0].length; i++) {

    type = "path";
    upgrade = "";
    random = (int)random(100);
    Tiles fill;
    fill = new Path(images);
    if(i == 0 || i == test[0].length-1){
      fill = new Water(images);
    }else{
    if (random > 92 ) {
      fill = new Wall(images);
    } else if( random > 90){
     
   // fill = new Hole(images);
  }}
      //chance of upgrades appearing
  if(fill.placeable == true && random(100) >70){
      if (random(100) >97) {
        fill.upgrade = new Wings();
      }
      if (random(100) >99) {
        fill.upgrade = new Shield();
      }
            if (random(100) >93 && (i == 1 || i == test[0].length -2) ) {
        fill.upgrade = new Boat();
      }
      if (random(100) >95 && score > 1000) {
        fill.upgrade = new Speed();
      }
  }

    test[0][i] = fill;
  } 
  // all under this line is for path creation.---------------------------------------------------------------------------------------------------------
  int corectX =  test[0].length - 1;

  //save old ghost positions

  for (int i = ghost[0].length -1; i >= 0; i--) {

    ghost[1][i] = ghost[0][i];
  } 

  //test tiles for path
  //kill ghost that are not on path or dit not exist
  for (int i = 0; i < ghost[0].length; i++) {

    if (test[corectX - i][i].placeable && ghost[0][i] == true ) {

      ghost[0][i] = true;
    } else {
      ghost[0][i] = false;
    }
  }
  //test for living ghosts
  boolean check = false;
  for (int i = 0; i < ghost[0].length; i++) {
    if (ghost[0][i] == true) {
      check = true;
      break;
    }
  }
  //if there are no living ghost
  //add all old living ghost to possible path positions
  if (check == false) {

    pathOptions = new IntList();
    for (int i = 0; i < ghost[1].length; i++) {

      if (ghost[1][i] == true) {

        pathOptions.append(i);
      }
    }

    Tiles fill = new Path(images);
    int fixY = int(random(pathOptions.size()));
    ghost[0][pathOptions.get(fixY)] = true;

    test[corectX - pathOptions.get(fixY)][pathOptions.get(fixY) ] = fill;
  }
  //move current ghost to old
  for (int i = ghost[0].length -1; i >= 0; i--) {
    if (ghost[0][i] == true && foodCountDown <1 && test[(corectX - i )][i].placeable) {
      test[(corectX - i )][i].upgrade = new Food();
      foodCountDown = 20;
    }
    ghost[1][i] = ghost[0][i];
  } 
  //if pos next to ghost is free add ghost
  for (int i = 0; i < ghost[1].length; i++) {
    if (ghost[1][i] == true) {

      if (i+1 < ghost[0].length  && test[(corectX - i )- 1][i + 1].placeable && test[(corectX - i )][i + 1].placeable && test[(corectX - i ) +1 ][i + 1].placeable) {
        ghost[0][i + 1] = true;
      }
      if (i-1 >= 0 && (corectX - i) + 1 >=0 && test[corectX - i + 1][i - 1].placeable && test[corectX - i + 2][i - 1].placeable && test[corectX - i + 3][i - 1].placeable) {
        ghost[0][i-1] = true;
      }
    }
  }
}
// werkt nog niet, checkt meer plaatsen
boolean checkPath(int posY, int checklenght, String type) {
  int corectX =  test[0].length - 1;
  for (int i =0; i < checklenght; i++) {
    if (test[(corectX - posY + i)- 1][posY + 1].type != type) {
      return false;
    }
  }

  return true;
}