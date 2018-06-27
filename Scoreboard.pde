//Op het scoreboard worden de hoogst behaalde scores weergegeven, als de rij van het scoreboard groter
//wordt dan 5 regels dan worden alleen de hoogste weergegeven de laagste wordt verwijderd.

class scoreboard{

int[] score = new int[6];
int newScore = 0;

void draw() {
textAlign(LEFT);
fill(0,150,0);
int scoreBoxWidth = 410;
image(UIimages[0], width - ((width/2)+(scoreBoxWidth/2)),200);

//arraylist 
fill(0);
textSize(22);
int LeftScorePos = 10;
text("Highscore:",width - ((width/2)+(scoreBoxWidth/2))+LeftScorePos,225);
text(score[0],width - ((width/2)+(scoreBoxWidth/2))+ LeftScorePos,250);
text(score[1],width - ((width/2)+(scoreBoxWidth/2))+ LeftScorePos,290);
text(score[2],width - ((width/2)+(scoreBoxWidth/2))+ LeftScorePos,330);
text(score[3],width - ((width/2)+(scoreBoxWidth/2))+ LeftScorePos,370);
text(score[4],width - ((width/2)+(scoreBoxWidth/2))+ LeftScorePos,410);

text("Last Try:", width - ((width/2)+(-10))+LeftScorePos, 225);
text(newScore, width - ((width/2)+(-10))+LeftScorePos, 250);
   
}

void schuif(int i) {
  for (int j = score.length-1; j >= max(i,1); j--) {
        score[j] = score[j-1];
      }
}

void newScore(int newScore) {
  this.newScore = newScore;
  
if(score[0] <= newScore) {
  schuif(0);
  score[0] = newScore;
  newScore = score[0];
  
}
else if(score[1] <= newScore) {
  schuif(1);
  score[1] = newScore; 
  newScore = score[1];
}
else if(score[2] <= newScore) {
  schuif(2);
  score[2] = newScore; 
  newScore = score[2];
}
else if(score[3] <= newScore) {
  schuif(3);
  score[3] = newScore; 
  newScore = score[3];
}
else if(score[4] <= newScore) {
  schuif(4);
  score[4] = newScore; 
  newScore = score[4];
}
}
}