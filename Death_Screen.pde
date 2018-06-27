int deathCooldown = 0;
boolean first = false;

void deathscreen() {

  if (death == true) {
    if (score != 0 && !first) {
      first = true;
      resultaat.newScore(score);
    }
    playstate = false;
    smoke.activeParticle = false;
    foodParticle.activeParticle = false;
    fill(0, 0, 0, 100);
    rect(0, 0, width, height);
    fill(255, 255);
    textSize(64);
    textAlign(CENTER, BOTTOM);
    text("YOU DIED", width/2, height/8);

    fill(255, 255);
    textSize(32);
    textAlign(CENTER);
    text("Press any key to continue", width/2, height/2);

    resultaat.draw();

    speed = 0;
    if (keyPressed && key !='x'&& deathCooldown < millis()) {
      start();
      first = false;
      death = false;
      deathCooldown = 0;
    } else if (deathCooldown ==0) {
      deathCooldown = millis() + 500; 
      smoke.activeParticle = true;
      foodParticle.activeParticle = true;
    }
  }else{
   deathCooldown = millis() + 500;  
  }
}