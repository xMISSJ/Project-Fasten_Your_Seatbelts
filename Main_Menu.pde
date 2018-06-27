boolean playstate = false;
boolean pausestate = false;
int cooldown = 0;
void menu() {
  if (player.keyarr[2] == true && cooldown < millis() && death == false) {
    pausestate = !pausestate;
    playstate = !pausestate;
    cooldown = millis() + 500;
    smoke.activeParticle = false;
    foodParticle.activeParticle = false;
  }

  if (pausestate == true) {
    speed = 0;
    smoke.activeParticle = false;
    foodParticle.activeParticle = false;
    fill(0, 0, 0, 100);
    rect(0, 0, width, height);
    fill(255, 255);
    textSize(64);
    textAlign(CENTER, TOP);
    text("\n\n\n\nPAUSED\n Press x to continue", width/2, height/8);
        imageMode(CENTER);
    image(UIimages[1], width /2, height/8);
     imageMode(CORNER);
  } else if (speed == 0) {
    speed = orgspeed;
    smoke.activeParticle = true;
    foodParticle.activeParticle = true;
  }
  if (playstate == false && pausestate == false && death == false) {
    smoke.activeParticle = false;
    foodParticle.activeParticle = false;

    fill(0, 0, 0, 100);
    rect(0, 0, width, height);
    fill(255, 255);
    textSize(64);
    textAlign(CENTER, BOTTOM);
    //text("DINO DASH!", width/2, height/8);

    imageMode(CENTER);
    image(UIimages[1], width /2, height/8,UIimages[1].width*2,UIimages[1].height *2);
     imageMode(CORNER);
    fill(255, 255);
    textSize(32);
    textAlign(CENTER);
    text("Press any key to continue", width/2, height/2);


    speed = 0;
    if (keyPressed && key !='x')playstate = true;
    //if (keyPressed && key == 'x') sound[1].stop();
  } else if (speed == 0 && pausestate == false && death == false) {
    speed = orgspeed;
    smoke.activeParticle = true;
  }
}