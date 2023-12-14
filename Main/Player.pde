class Player {
  float x, y;
  float ySpeed;
  boolean jumping;
  PImage shipForward;
  PImage shipUp;
  PImage shipDown;

//Constructor for the player class
  Player(float x, float y) {
    this.x = x;
    this.y = y;
    this.ySpeed = 0;
    this.jumping = false;
    
    shipForward = loadImage("ShipForward.png");
    shipUp = loadImage("ShipUp.png");
    shipDown = loadImage("ShipDown.png");
  }

//Update function to check if the player is jumping
  void update() {
    if (jumping) {
      y += ySpeed;
      ySpeed += 0.5;
      
      y = constrain(y, 15, groundLevel);

      if (y >= groundLevel) {
        y = groundLevel;
        ySpeed = 0;
        jumping = false;
      }
    }
  }

//Function to display the player in three different states
  void display() {
    
   imageMode(CENTER);
 
    if (ySpeed == 0){
      image(shipForward, x, y, 70, 70);
    }
    
    if (ySpeed > 0){
      image(shipDown, x, y, 70, 70);
    }
    
    if (ySpeed < 0){
      image(shipUp, x, y, 70, 70);
    }
    
    imageMode(CORNER);
    
  }

//Checks to see if the player collides with any obstacles
  boolean checkCollision(Obstacle obs) {
    float obsX = obs.getX();
    float obsY = obs.getY();
    float obsWidth = obs.getWidth();
    float obsHeight = obs.getHeight();

    return (x + 15 > obsX && x - 15 < obsX + obsWidth && y + 15 > obsY && y - 15 < obsY + obsHeight);
  }

//Checks to see if the player collides with any platforms
  boolean checkCollision(Platform platform) {
    float playerBottom = y + 15;
    float platformTop = platform.getY();
    float platformBottom = platformTop + platform.getHeight();

    if (x + 15 > platform.getX() && x - 15 < platform.getX() + platform.getWidth() && playerBottom > platformTop && y < platformBottom) {
      return true;
    }
    return false;
  }

//Function to allow jumping
  void jump() {
    if (gameRunning) {
      jumping = true;
      ySpeed = -10;
    }
  }

  boolean isJumping() {
    return jumping;
  }


//function to handle the platform collission 
  void handlePlatformCollision(Platform platform) {
    if (ySpeed >= 0) { // Only handle collision when moving downwards
      float playerBottom = y + 15;
      float platformTop = platform.getY();
      
      //Keep player on top of the platform if the player is on top of the platform
        if (playerBottom > platformTop) {
        jumping = false;
        ySpeed = 0;
        y = platformTop - 15; // Adjust the player's position to be just above the platform
      }
      
      //Once the player is off the platform they will fall off
       if (playerBottom > platform.getX()) {
        jumping = true;
        ySpeed = 0;
      }
    
    }
  }

//Function to reset player x and y when game is reset
  void reset(float x, float y) {
    this.x = x;
    this.y = y;
    this.ySpeed = 0;
    this.jumping = false;
  }
}
