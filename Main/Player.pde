class Player {
  float x, y;
  float ySpeed;
  boolean jumping;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
    this.ySpeed = 0;
    this.jumping = false;
  }

  void update() {
    if (jumping) {
      y += ySpeed;
      ySpeed += 0.5;

      if (y >= groundLevel) {
        y = groundLevel;
        ySpeed = 0;
        jumping = false;
      }
    }
  }

  void display() {
    fill(255, 0, 0);
    ellipse(x, y, 30, 30);
  }

  boolean checkCollision(Obstacle obs) {
    float obsX = obs.getX();
    float obsY = obs.getY();
    float obsWidth = obs.getWidth();
    float obsHeight = obs.getHeight();

    return (x + 15 > obsX && x - 15 < obsX + obsWidth && y + 15 > obsY && y - 15 < obsY + obsHeight);
  }

  boolean checkCollision(Platform platform) {
    float playerBottom = y + 15;
    float platformTop = platform.getY();
    float platformBottom = platformTop + platform.getHeight();

    if (x + 15 > platform.getX() && x - 15 < platform.getX() + platform.getWidth() && playerBottom > platformTop && y < platformBottom) {
      return true;
    }

    return false;
  }

  void jump() {
    if (!jumping) {
      jumping = true;
      ySpeed = -10;
    }
  }

  boolean isJumping() {
    return jumping;
  }

  void handlePlatformCollision(Platform platform) {
    if (ySpeed >= 0) { // Only handle collision when moving downwards
      float playerBottom = y + 15;
      float platformTop = platform.getY();
      
        if (playerBottom > platform.getY() ) {
        jumping = false;
        ySpeed = 0;
        y = platformTop - 15; // Adjust the player's position to be just above the platform
      }
      
       if (playerBottom > platform.getX()) {
        jumping = true;
        ySpeed = 0;
      }
    
    }
  }

  void reset(float x, float y) {
    this.x = x;
    this.y = y;
    this.ySpeed = 0;
    this.jumping = false;
  }
}
