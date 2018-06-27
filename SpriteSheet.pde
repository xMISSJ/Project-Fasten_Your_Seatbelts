class SpriteSheet {

  // The image containing the frames and the image to draw
  PImage sourceImage;
  int fps = 10;
  int frame = 0;
  int frameWidth;
  int frameHeight;
  int nFrames = 0;
  int x, y;

  //this constructor takes the image to animate and the amount of frames
  SpriteSheet(String imageName, int nFrames) {
    sourceImage = loadImage(imageName);
    this.nFrames = nFrames;
    frameWidth = sourceImage.width/nFrames;
    frameHeight = sourceImage.height;
  }

  // this method runs through the image and starts back at the beginning when it has finished drawing all frames
  void update() {
    if ((frameCount % fps) == 0)    
      frame =  (frame + 1) % nFrames;
  }

  void draw() {
    
    // draw the image based on the information provided about it.
    copy(sourceImage, 
      frame*frameWidth, 0, frameWidth, frameHeight, 
      x-frameWidth/2, y-frameHeight/2, frameWidth, frameHeight);
  }
}